################################################################################
# Migrations: v5.60 -> v6.0
################################################################################

# AWS Gateway Controller
moved {
  from = aws_iam_policy.aws_gateway_controller
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.aws_gateway_controller
  to   = aws_iam_policy.this
}

# Cert Manager
moved {
  from = aws_iam_policy.cert_manager
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.cert_manager
  to   = aws_iam_policy.this
}

# Cluster Autoscaler
moved {
  from = aws_iam_policy.cluster_autoscaler
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.cluster_autoscaler
  to   = aws_iam_policy.this
}

# EBS CSI
moved {
  from = aws_iam_policy.ebs_csi
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.ebs_csi
  to   = aws_iam_policy.this
}

# EFS CSI
moved {
  from = aws_iam_policy.efs_csi
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.efs_csi
  to   = aws_iam_policy.this
}

# Mountpoint S3 CSI
moved {
  from = aws_iam_policy.mountpoint_s3_csi
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.mountpoint_s3_csi
  to   = aws_iam_policy.this
}

# External DNS
moved {
  from = aws_iam_policy.external_dns
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.external_dns
  to   = aws_iam_policy.this
}

# External Secrets
moved {
  from = aws_iam_policy.external_secrets
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.external_secrets
  to   = aws_iam_policy.this
}

# FSx OpenZFS CSI
moved {
  from = aws_iam_policy.fsx_openzfs_csi
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.fsx_openzfs_csi
  to   = aws_iam_policy.this
}

# AWS Load Balancer Controller
moved {
  from = aws_iam_policy.load_balancer_controller
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.load_balancer_controller
  to   = aws_iam_policy.this
}

# AWS Load Balancer Controller - Target Group Binding Only
moved {
  from = aws_iam_policy.load_balancer_controller_targetgroup_only
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.load_balancer_controller_targetgroup_only
  to   = aws_iam_policy.this
}

# Amazon Managed Service for Prometheus
moved {
  from = aws_iam_policy.amazon_managed_service_prometheus
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.amazon_managed_service_prometheus
  to   = aws_iam_policy.this
}

# Node Termination Handler
moved {
  from = aws_iam_policy.node_termination_handler
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.node_termination_handler
  to   = aws_iam_policy.this
}

# Velero
moved {
  from = aws_iam_policy.velero
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.velero
  to   = aws_iam_policy.this
}

# VPC CNI
moved {
  from = aws_iam_policy.vpc_cni
  to   = aws_iam_policy.this
}

moved {
  from = aws_iam_role_policy_attachment.vpc_cni
  to   = aws_iam_policy.this
}
