terraform {
  required_version = ">= 1.5"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "greeting" {
  description = "Text written to the generated file."
  type        = string
  default     = "hello from the cookbook"
}

resource "local_file" "greeting" {
  content  = "${var.greeting}\n"
  filename = "${path.module}/greeting.txt"
}

output "path" {
  description = "Path of the generated file."
  value       = local_file.greeting.filename
}
