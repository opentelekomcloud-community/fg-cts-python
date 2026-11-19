resource "opentelekomcloud_fgs_trigger_v2" "ctsstrigger" {
  function_urn = opentelekomcloud_fgs_function_v2.MyFunction.urn
  type         = "CTS"
  status       = "ACTIVE"
  # status = "DISABLED"

  event_data = jsonencode({
    "name" : lower("cts_event"),
    "operations" : [
      "IAM:user:login;logout"
    ]
  })


}
