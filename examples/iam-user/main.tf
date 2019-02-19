provider "aws" {
  region = "eu-west-1"
}

#########################################
# IAM user, login profile and access key
#########################################
module "iam_user" {
  source = "../../modules/iam-user"

  name          = "vasya.pupkin"
  force_destroy = true

  # User "test" has uploaded his public key here - https://keybase.io/test/pgp_keys.asc
  pgp_key = "keybase:test"

  password_reset_required = false

  # SSH public key
  upload_iam_user_ssh_key = true

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0sUjdTEcOWYgQ7ESnHsSkvPUO2tEvZxxQHUZYh9j6BPZgfn13iYhfAP2cfZznzrV+2VMamMtfiAiWR39LKo/bMN932HOp2Qx2la14IbiZ91666FD+yZ4+vhR2IVhZMe4D+g8FmhCfw1+zZhgl8vQBgsRZIcYqpYux59FcPv0lP1EhYahoRsUt1SEU2Gj+jvgyZpe15lnWk2VzfIpIsZ++AeUqyHoJHV0RVOK4MLRssqGHye6XkA3A+dMm2Mjgi8hxoL5uuwtkIsAll0kSfL5O2G26nsxm/Fpcl+SKSO4gs01d9V83xiOwviyOxmoXzwKy4qaUGtgq1hWncDNIVG/aQ=="
}

###################################################################
# IAM user without pgp_key (IAM access secret will be unencrypted)
###################################################################
module "iam_user2" {
  source = "../../modules/iam-user"

  name = "vasya.pupkin4"

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}
