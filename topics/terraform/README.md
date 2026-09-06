# Terraform / IaC

Infrastructure-as-code notes and self-contained examples.

## Contents

- `notes/` — prose notes (state, modules, workspaces, provider auth).
- `examples/local-file/` — a credential-free example using the `hashicorp/local` provider.

## Validation

CI runs, without `terraform init` or provider downloads:

```bash
terraform fmt -check -recursive .
tflint --recursive
```

Examples must be formatted and free of `tflint` warnings. Prefer providers that need no
cloud credentials (`local`, `random`, `null`, `tls`) so examples stay runnable anywhere.
