################################################################################
# IAM Role - Instance Profile
################################################################################

output "instance_profile_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_instance_profile.name
}

output "instance_profile_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_instance_profile.arn
}

output "instance_profile_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_instance_profile.unique_id
}

output "instance_profile_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_instance_profile.instance_profile_arn
}

output "instance_profile_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_instance_profile.instance_profile_id
}

output "instance_profile_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_instance_profile.instance_profile_name
}

output "instance_profile_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_instance_profile.instance_profile_unique_id
}

################################################################################
# IAM Role - Conditions
################################################################################

output "conditions_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_conditions.name
}

output "conditions_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_conditions.arn
}

output "conditions_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_conditions.unique_id
}

output "conditions_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_conditions.instance_profile_arn
}

output "conditions_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_conditions.instance_profile_id
}

output "conditions_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_conditions.instance_profile_name
}

output "conditions_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_conditions.instance_profile_unique_id
}
