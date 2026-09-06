# Getting started with Terraform notes

Add notes as `NN-topic.md`. Keep each example in its own `../examples/<name>/` directory
with its own `main.tf` so `terraform fmt` / `tflint` can run per-directory.

## Core workflow

```bash
terraform init
terraform fmt
terraform validate
terraform plan -out tfplan
terraform apply tfplan
terraform destroy
```

## Conventions

- Pin `required_version` and every provider version in a `terraform {}` block.
- One resource concern per file (`main.tf`, `variables.tf`, `outputs.tf`) once an example grows.
- Never commit `*.tfstate` or `.terraform/` (see repo `.gitignore`).
