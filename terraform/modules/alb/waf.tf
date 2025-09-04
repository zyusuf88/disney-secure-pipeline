resource "aws_wafv2_web_acl" "alb" {
  name        = "${var.project_name}-${var.environment}-waf"
  description = "Web ACL for ALB"
  scope       = var.waf_scope

  default_action {
    allow {}
  }


  dynamic "rule" {
    for_each = var.waf_rules
    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.managed_rule_group_name
          vendor_name = rule.value.vendor_name
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.waf_visibility_config.cloudwatch_metrics_enabled
    metric_name                = var.waf_visibility_config.metric_name
    sampled_requests_enabled   = var.waf_visibility_config.sampled_requests_enabled
  }
}

resource "aws_wafv2_web_acl_association" "alb" {
  resource_arn = aws_lb.this.arn
  web_acl_arn  = aws_wafv2_web_acl.alb.arn
}
