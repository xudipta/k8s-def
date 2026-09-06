# Kubernetes

A quick reference for Kubernetes definition files and `kubectl` usage.

## Contents

- `notes/kubectl-commands.md` — common `kubectl` commands (create, edit, extract, redeploy).
- `examples/pod/` — Pod definitions.
- `examples/deployment/` — Deployment definitions.
- `examples/replicaset/` — ReplicaSet definitions.
- `examples/services/` — Service definitions.
- `examples/configs/` — ConfigMap definitions.
- `examples/secrets/` — Secret definitions.

## Usage

```bash
kubectl apply -f examples/pod/sample-pod.yaml
kubectl apply -f examples/deployment/deployment-with-configmap-secret.yaml
kubectl apply -f examples/pod/pod-with-security-context.yaml
kubectl apply -f examples/deployment/deployment-with-security-context.yaml
```

## SecurityContext

`securityContext` works at two levels:

- **Pod-level** (`spec.securityContext`) — applies to all containers in the Pod.
- **Container-level** (`spec.containers[].securityContext`) — applies to that container only.

See `examples/pod/pod-with-security-context.yaml` and
`examples/deployment/deployment-with-security-context.yaml`.

## ConfigMaps and Secrets

ConfigMaps and Secrets can be injected as environment variables or mounted as volumes.
`examples/pod/pod-with-configmap-secret.yaml` and
`examples/deployment/deployment-with-configmap-secret.yaml` demonstrate both.

## Validation

- `yamllint` runs on every `*.yaml` change.
- `kubeconform` schema-validates every manifest under `examples/`.
- A `kind` cluster applies `secrets/`, `configs/`, `deployment/`, `services/`, waits for
  the Deployment to become available, and curls the Service to confirm nginx responds.
