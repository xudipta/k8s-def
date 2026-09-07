# Terraform / IaC

Infrastructure-as-code notes and self-contained examples.

## Contents

- `notes/01-core-workflow.md` — `init`/`plan`/`apply`/`destroy`, reading a plan, how state
  tracks resources, walking through `examples/local-file`.
- `notes/02-variables-and-modules.md` — setting variables, outputs, extracting a module.
- `notes/03-state-and-workspaces.md` — remote backends, state locking, workspaces vs.
  per-environment directories.
- `examples/local-file/` — a credential-free example using the `hashicorp/local` provider.

New to Terraform? Start with `notes/01-core-workflow.md` and run `examples/local-file`
alongside it.

## Validation

A fast static job runs first, without `terraform init` or provider downloads:

```bash
terraform fmt -check -recursive .
tflint --recursive
```

A separate, slower job then actually runs `examples/local-file`: `terraform init`,
`apply`, checks `greeting.txt` was created with the expected content, then `destroy` —
catching anything the static checks can't (a provider version that no longer resolves, a
resource attribute renamed upstream).

```bash
cd examples/local-file
terraform init && terraform apply -auto-approve
grep -q 'hello from the cookbook' greeting.txt
terraform destroy -auto-approve
```

Examples must be formatted and free of `tflint` warnings. Prefer providers that need no
cloud credentials (`local`, `random`, `null`, `tls`) so examples stay runnable anywhere.
