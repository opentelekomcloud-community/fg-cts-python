# Terraform configuration for testing CTS login events with allowed and denied source IPs
 
resource "opentelekomcloud_fgs_event_v2" "test_event_allowed" {
  function_urn = opentelekomcloud_fgs_function_v2.MyFunction.urn
  name         = "test-allowed-source-ip"

  content = base64encode(jsonencode(
    {
      "cts" = {
        "request"       = {},
        "trace_id"      = "d1b8942f-e341-11f1-9cf1-93d91c21b000",
        "code"          = 302,
        "trace_name"    = "login",
        "resource_type" = "user",
        "trace_rating"  = "normal",

        "message" = jsonencode({
          "login" = {
            "mode"      = "password",
            "user_type" = "iam user",
            "login_protect" = {
              "status" = "off"
            }
          }
        }),
        "source_ip"     = var.TEST_ALLOWED_SOURCE_IP,
        "domain_id"     = var.OTC_SDK_DOMAIN_ID,
        "service_type"  = "IAM",
        "trace_type"    = "ConsoleAction",
        "project_id"    = var.OTC_SDK_PROJECTID,
        "read_only"     = false,
        "response"      = {},
        "resource_id"   = var.TEST_USER_ID,
        "trace_status"  = "normal",
        "time"          = 1795000725593,
        "resource_name" = var.TEST_USER_NAME,
        "record_time"   = 1795000725593,
        "user" = {
          "domain" = {
            "name" = var.OTC_SDK_DOMAIN_NAME,
            "id"   = var.OTC_SDK_DOMAIN_ID
          },
          "name" = var.TEST_USER_NAME,
          "id"   = var.TEST_USER_ID
        }
      }
    }
  ))
}

resource "opentelekomcloud_fgs_event_v2" "test_event_denied" {
  function_urn = opentelekomcloud_fgs_function_v2.MyFunction.urn
  name         = "test-denied-source-ip"

  content = base64encode(jsonencode(
    {
      "cts" = {
        "request"       = {},
        "trace_id"      = "d1b8942f-e341-11f1-9cf1-93d91c21b001",
        "code"          = 302,
        "trace_name"    = "login",
        "resource_type" = "user",
        "trace_rating"  = "normal",
        "message" = jsonencode({
          "login" = {
            "mode"      = "password",
            "user_type" = "iam user",
            "login_protect" = {
              "status" = "off"
            }
        } }),
        "source_ip"     = var.TEST_DENIED_SOURCE_IP,
        "domain_id"     = var.OTC_SDK_DOMAIN_ID,
        "service_type"  = "IAM",
        "trace_type"    = "ConsoleAction",
        "project_id"    = var.OTC_SDK_PROJECTID,
        "read_only"     = false,
        "response"      = {},
        "resource_id"   = var.TEST_USER_ID,
        "trace_status"  = "normal",
        "time"          = 1795000725595,
        "resource_name" = var.TEST_USER_NAME,
        "record_time"   = 1795000725595,
        "user" = {
          "domain" = {
            "name" = var.OTC_SDK_DOMAIN_NAME,
            "id"   = var.OTC_SDK_DOMAIN_ID
          },
          "name" = var.TEST_USER_NAME,
          "id"   = var.TEST_USER_ID
        }
      }
    }
  ))
}
