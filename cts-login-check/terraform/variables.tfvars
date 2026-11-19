# Terraform variables for scratch-event sample

# prefix of all resources
prefix        = "python"

# description of the function
description = "Custom rule for CTS login check"

# name of the function (will be prefixed)
function_name = "fg-cts-login"

# handler function name defined in your code, e.g. "index.handler"
handler_name = "index.handler"

# resources will be tagged with this app_group tag
tag_app_group = "fg-cts-login"

SMN_ENDPOINT = "smn.eu-de.otc.t-systems.com"