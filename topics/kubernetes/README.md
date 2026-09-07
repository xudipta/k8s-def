# Kubernetes

Notes and example manifests for core Kubernetes objects and `kubectl` usage.

## Contents

- `notes/01-kubectl-commands.md` — create/apply/edit/extract, inspecting and debugging
  with `describe`/`logs`/`exec`, scaling and rollouts, port-forwarding, namespaces.
- `notes/02-pods-and-workloads.md` — Pods vs. ReplicaSets vs. Deployments, how labels and
  selectors tie them together, walking through `examples/pod/`, `examples/replicaset/`,
  and `examples/deployment/sample-deployment.yaml`.
- `notes/03-config-and-secrets.md` — ConfigMap vs. Secret, env vars vs. volume mounts,
  walking through `examples/configs/`, `examples/secrets/`, and the
  `*-with-configmap-secret.yaml` examples.
- `notes/04-services-and-networking.md` — Service types, selectors/endpoints, cluster
  DNS, walking through `examples/services/sample-service.yaml`; Ingress, briefly.
- `notes/05-security-context.md` — Pod- vs. container-level `securityContext`, the fields
  that matter, walking through the `*-with-security-context.yaml` examples.
- `notes/06-helm-and-kustomize.md` — templating + release tracking vs. patch overlays,
  walking through `examples/helm/` and `examples/kustomize/` (with diagrams).
- `examples/pod/` — Pod definitions.
- `examples/deployment/` — Deployment definitions.
- `examples/replicaset/` — ReplicaSet definitions.
- `examples/services/` — Service definitions.
- `examples/configs/` — ConfigMap definitions.
- `examples/secrets/` — Secret definitions.
- `examples/helm/sample-chart/` — a minimal Helm chart.
- `examples/kustomize/` — a `base/` with `dev`/`prod` overlays.

New here? Start with `notes/01-kubectl-commands.md`, then `notes/02-pods-and-workloads.md`
alongside `examples/pod/sample-pod.yaml`.

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

See `notes/05-security-context.md`, `examples/pod/pod-with-security-context.yaml`, and
`examples/deployment/deployment-with-security-context.yaml`.

## ConfigMaps and Secrets

ConfigMaps and Secrets can be injected as environment variables or mounted as volumes.
See `notes/03-config-and-secrets.md`, `examples/pod/pod-with-configmap-secret.yaml`, and
`examples/deployment/deployment-with-configmap-secret.yaml`.

## Validation

- `yamllint` runs on every `*.yaml` change.
- `kubeconform` schema-validates every manifest under `examples/`, including the
  Deployment/Service rendered from `examples/helm/sample-chart` (`helm template`) and
  from each `examples/kustomize/overlays/*` (`kubectl kustomize`).
- `helm lint` checks `examples/helm/sample-chart`.
- A `kind` cluster applies `secrets/`, `configs/`, `deployment/`, `services/`, waits for
  the Deployment to become available, and curls the Service to confirm nginx responds.
