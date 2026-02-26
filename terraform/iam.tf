resource "aws_iam_role" "identity_service_role" {
  name = "identity-service-cognito-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Change to EKS OIDC provider later
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "cognito_access" {
  name = "cognito-admin-access"
  role = aws_iam_role.identity_service_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminGetUser",
          "cognito-idp:AdminUpdateUserAttributes",
          "cognito-idp:AdminSetUserPassword"
        ]
        Effect   = "Allow"
        Resource = aws_cognito_user_pool.pool.arn
      },
    ]
  })
}