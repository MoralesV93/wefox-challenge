generate "core_configuration" {
    path = "core-config.tf"
    if_exists = "overwrite_terragrunt"
  contents = <<-EOF
  # DEFUALT PROVIDER -----------------------------
  provider "kubernetes" {
    config_path = "~/.kube/config"
  }
  terraform {
    required_providers {
      kubernetes = {
        source  = "hashicorp/kubernetes"
        version = ">= 2.0.0"
      }
    }
    required_version = ">= 0.13"
  }
#-----------------------------------------------

# ASSINGED COMMON VARIABLES -------------------
variable "environment" {default = "prod"}
variable "default_tags" {default =  { "manager" = "terraform", "environment" = "prod", "path" = "preproduction/${path_relative_to_include()}","namespace_key" = "wefox" }}
variable "namespace" {default= "wefox"}
#-----------------------------------------------
  EOF
}