resource "aws_cognito_user_pool" "pool" {
  name = "${var.project_name}-user-pool"

  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  # Email verification setup
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  # DEV: "OFF" (Advanced security costs ~$0.050 per active user)
  # PROD: advanced_security_mode = "AUDIT" or "ENFORCED"
  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  # DEV: "OFF" (Saves you from getting SMS charges if you don't have SES set up)
  # PROD: mfa_configuration = "OPTIONAL"
  mfa_configuration = "OFF"

  software_token_mfa_configuration {
    enabled = true
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "gatekeeper-web-client"
  user_pool_id = aws_cognito_user_pool.pool.id

  generate_secret = true

  # ADMIN_NO_SRP allows your FastAPI backend to facilitate login easily
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ADMIN_NO_SRP_AUTH"
  ]
}