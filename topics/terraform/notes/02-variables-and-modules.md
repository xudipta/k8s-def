# Variables, outputs, and modules

## Variables

```hcl
variable "greeting" {
  description = "Text written to the generated file."
  type        = string
  default     = "hello from the cookbook"
}
```

Set a value, in order of precedence (later overrides earlier):

```bash
terraform apply -var 'greeting=hi'          # CLI flag
terraform apply -var-file="prod.tfvars"     # -var-file
# TF_VAR_greeting=hi terraform apply         # environment variable
# a *.auto.tfvars file in the working dir is loaded automatically
```

Use `sensitive = true` on a variable holding a secret so Terraform redacts it from plan
output — it's still stored in plaintext in state, so pair it with a remote backend that
encrypts state at rest.

## Outputs

```hcl
output "path" {
  description = "Path of the generated file."
  value       = local_file.greeting.filename
}
```

```bash
terraform output              # all outputs
terraform output path          # one output, unquoted with -raw
terraform output -json         # machine-readable, for piping into another tool/module
```

## Modules

A module is just a directory of `.tf` files; every root config is itself a module.
Extract one once an example grows past a single reusable unit:

```hcl
module "app" {
  source = "./modules/app"

  name   = "hello"
  greeting = var.greeting
}
```

```bash
terraform get                # (re)download/refresh module sources
terraform init -upgrade       # also upgrade provider versions per version constraints
```

Conventions worth following as a config grows:

- One resource concern per file (`main.tf`, `variables.tf`, `outputs.tf`) — see
  `CONTRIBUTING.md`'s guidance for this repo's examples.
- Pin `required_version` and every provider's version in a `terraform {}` block (see
  `examples/local-file/main.tf`) so `terraform init` is reproducible.
- A module's `variables.tf` is its public interface — keep it minimal and documented
  (`description` on every variable and output).
