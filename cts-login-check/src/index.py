import ipaddress

import requests


# Handler for CTS login/logout events and IP whitelist checking.
def handler(event, context):
    logger = context.getLogger()

    logger.debug("event: %s", event)

    ctsmsg = event["cts"]

    # Resource operator IP
    SOURCE_IP = ctsmsg["source_ip"]
    # trace_name
    ACTION = ctsmsg["trace_name"]

    IP_RANGES_WHITELIST = context.getUserData("IP_RANGES_WHITELIST")

    if not IP_RANGES_WHITELIST:
        return "IP_RANGES_WHITELIST is not configured, fail"

    if ACTION not in ("login", "logout"):
        return f"Action {ACTION} is not valid, fail"

    body = {
        "subject": f"CTSTrigger: Illegal {ACTION} from non-whitelisted IP",
        "message": f"Illegal operation [{ACTION}] from [{SOURCE_IP}], user [{ctsmsg['user']['name']}]",
    }

    # Check if source IP is in the whitelist
    for ip_range in IP_RANGES_WHITELIST.split(","):
        try:
            if ipaddress.ip_address(SOURCE_IP) in ipaddress.ip_network(
                ip_range.strip(), strict=False
            ):
                return f"Reasonable {ACTION} from IP {SOURCE_IP}"
        except ValueError:
            logger.error(f"Invalid IP range: {ip_range}")
            body = {
                "subject": "Configuration Error",
                "message": f"CTSTrigger: Invalid IP range {ip_range} configured in IP_RANGES_WHITELIST: {IP_RANGES_WHITELIST}",
            }
            break

    return send_alarm_message(context, body)


# Send an alarm message to the specified SMN topic using the provided context and message body.
# Reference: https://docs.otc.t-systems.com/simple-message-notification/api-ref/apis/message_publishing/publishing_messages_in_the_text_format.html
def send_alarm_message(context, body: dict) -> str:
    logger = context.getLogger()

    SMN_ENDPOINT = context.getUserData("SMN_ENDPOINT")
    SMN_TOPIC_URN = context.getUserData("SMN_TOPIC_URN")
    PROJECT_ID = context.getProjectID()
    TOKEN = context.getToken()

    logger.info(
        f"Sending alarm message to SMN topic {SMN_TOPIC_URN} at endpoint {SMN_ENDPOINT}"
    )

    headers = {"X-Auth-Token": TOKEN, "accept": "application/json"}

    url = f"https://{SMN_ENDPOINT}/v2/{PROJECT_ID}/notifications/topics/{SMN_TOPIC_URN}/publish"

    return_value = None
    try:
        response = requests.post(url, headers=headers, json=body, timeout=10)
        if response.status_code != 200:
            logger.error(
                f"Failed to send alarm message, status code: {response.status_code}"
            )
            return_value = "Send alarm message failed."
        else:
            return_value = "Send alarm message success." 

    except requests.exceptions.RequestException as error:
        logger.error(f"Failed to send alarm message: {error}")
        return_value = "Send alarm message failed."

    return return_value
