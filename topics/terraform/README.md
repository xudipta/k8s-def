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

CI runs, without `terraform init` or provider downloads:

```bash
terraform fmt -check -recursive .
tflint --recursive
```

Examples must be formatted and free of `tflint` warnings. Prefer providers that need no
cloud credentials (`local`, `random`, `null`, `tls`) so examples stay runnable anywhere.
