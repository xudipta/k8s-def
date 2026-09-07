# Core workflow

Terraform describes infrastructure declaratively in `.tf` files and reconciles real
resources to match. The core loop:

```bash
terraform init                 # download providers, set up the backend
terraform fmt                  # canonical formatting
terraform validate             # syntax + internal consistency, no provider calls
terraform plan -out tfplan     # compute the diff between config and real state
terraform apply tfplan         # apply exactly that plan
terraform destroy               # tear everything down
```

Always `plan` before `apply` and read the diff — `+` create, `-` destroy, `~` update
in place, `-/+` destroy-and-recreate (the latter matters: some attribute changes force
replacement, e.g. renaming an AWS S3 bucket).

## Try it: `examples/local-file`

Uses `hashicorp/local` so it runs with no cloud credentials:

```bash
cd topics/terraform/examples/local-file
terraform init
terraform plan
terraform apply -auto-approve
cat greeting.txt
terraform destroy -auto-approve
```

Change `var.greeting` (`-var 'greeting=hi'` or edit the `default`) and re-run `plan` to
see a `~` update-in-place instead of a fresh create.

## State

Terraform tracks what it created in a **state file** (`terraform.tfstate` — never commit
it; see `.gitignore`). State maps each resource block to a real-world ID; `plan` diffs
*config vs. state*, then separately checks state against *real infrastructure* (a
`refresh`, done automatically as part of `plan`/`apply`).

```bash
terraform state list                    # resources currently tracked
terraform state show local_file.greeting  # one resource's tracked attributes
terraform import <addr> <id>             # bring an existing resource under management
```

If state and reality disagree (someone changed a resource outside Terraform), the next
`plan` shows Terraform's proposal to reconcile them — read it before applying, it may
mean "revert the manual change" rather than what you expected.
