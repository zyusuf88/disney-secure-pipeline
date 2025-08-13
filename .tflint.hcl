plugin "terraform" {
  enabled = true
}

# Disable just the provider/version rules
rule "terraform_required_providers" {
  enabled = false
}

rule "terraform_required_version" {
  enabled = false
}
