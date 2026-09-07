# Remote state, locking, and workspaces

## Why remote state

The default **local** backend keeps `terraform.tfstate` on disk — fine for the
credential-free examples in this repo, but unworkable once more than one person or CI job
applies the same config: two concurrent `apply`s can corrupt state or fight each other's
changes.

A **remote backend** stores state centrally and (for backends that support it) locks it
during an operation:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-tfstate"
    key            = "myapp/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock"   # locking, so concurrent applies queue instead of racing
    encrypt        = true
  }
}
```

```bash
terraform init -migrate-state   # move existing local state into the new backend
terraform force-unlock <lock-id>  # only if a crashed run left a stale lock — verify first
```

Never edit the state file by hand; use `terraform state mv` / `rm` / `import` for
surgical changes.

## Workspaces

Workspaces let one config manage multiple, isolated state files (e.g. `dev`/`staging`)
without duplicating `.tf` files:

```bash
terraform workspace list
terraform workspace new staging
terraform workspace select staging
terraform apply   # applies against staging's own state
```

```hcl
resource "aws_instance" "app" {
  # differentiate per workspace via terraform.workspace
  instance_type = terraform.workspace == "prod" ? "m5.large" : "t3.micro"
}
```

Workspaces share the *same* backend and variable set — for environments that need
genuinely different configuration (different accounts, different modules), a separate
directory per environment (each with its own backend config and `.tfvars`) is usually
clearer than workspaces.

## Drift and locking, in practice

- Run `terraform plan` on a schedule (or before every apply) to catch drift — resources
  changed outside Terraform — before it surprises an `apply`.
- A stuck lock almost always means a previous run was killed mid-apply; confirm no
  `apply` is actually in flight before `force-unlock`.
- Keep state encrypted at rest (`encrypt = true` above) — it contains resource
  attributes verbatim, including anything marked `sensitive` in a variable.
