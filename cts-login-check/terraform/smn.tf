# Create an SMN topic and subscriptions for the FunctionGraph function

# Create an SMN topic for the FunctionGraph function
resource "opentelekomcloud_smn_topic_v2" "topic_1" {
  name         = format("%s_%s_topic_1", var.prefix, var.function_name)
  display_name = format("Message from FG function: %s", var.function_name)

  tags = {
    "app_group" = var.tag_app_group
  }
}

# Create SMN subscriptions for each email address in the list
resource "opentelekomcloud_smn_subscription_v2" "subscriptions" {
  for_each = var.SMN_EMAIL_ADDRESS
  endpoint  = each.value
  topic_urn = opentelekomcloud_smn_topic_v2.topic_1.topic_urn
  protocol  = "email"  
  remark = format("Subscription for %s", var.function_name)  
}