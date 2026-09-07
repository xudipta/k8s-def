# Pods, ReplicaSets, and Deployments

## Pods

A **Pod** is the smallest deployable unit — one or more containers that share a network
namespace (same `localhost`) and can share volumes. Most Pods run exactly one container;
multiple containers in one Pod are for tightly-coupled helpers (a sidecar, an init
container), not for unrelated services.

```bash
kubectl apply -f examples/pod/sample-pod.yaml
kubectl get pod sample-pod
kubectl describe pod sample-pod
kubectl delete pod sample-pod
```

`examples/pod/sample-pod.yaml` is about as minimal as a Pod gets: one container, one
image, one exposed port. Pods created directly like this are **not self-healing** — if
the node dies or the container crashes past its restart policy, nothing recreates it.
That's what a controller (below) is for.

## ReplicaSets

A **ReplicaSet** keeps a specified number of identical Pod replicas running, using
`spec.selector` to find which Pods it owns (by label) and `spec.template` to define what
a replica looks like.

```bash
kubectl apply -f examples/replicaset/sample-replicaset.yaml
kubectl get replicaset sample-replicaset
kubectl get pods -l app=nginx        # the Pods it's managing, found by label
kubectl delete pod <one-of-the-pods> # the ReplicaSet notices and creates a replacement
```

Try the last two commands against `examples/replicaset/sample-replicaset.yaml` — deleting
one Pod, watching `kubectl get pods -l app=nginx -w` recreate it, is the clearest way to
see self-healing happen.

You rarely create a ReplicaSet directly (as this example does, for illustration) — in
practice a Deployment creates and owns one for you.

## Deployments

A **Deployment** manages ReplicaSets for you and adds rolling updates: change
`spec.template` (e.g. bump the image tag) and re-`apply`, and the Deployment creates a
new ReplicaSet, scales it up, and scales the old one down gradually — no downtime, and
`kubectl rollout undo` if the new version is bad.

```bash
kubectl apply -f examples/deployment/sample-deployment.yaml
kubectl get deployment sample-deployment
kubectl get replicaset -l app=nginx     # the ReplicaSet the Deployment created
kubectl set image deployment/sample-deployment nginx=nginx:1.27
kubectl rollout status deployment/sample-deployment
```

`examples/deployment/sample-deployment.yaml` differs from the ReplicaSet example only in
`kind` and that it's a Deployment wrapping the same Pod template — that's the normal
relationship: **Deployment → owns a ReplicaSet → owns Pods**.

## Which one to write

- Ad-hoc debugging, a one-off tool container → a bare **Pod** (or `kubectl run`).
- Almost everything else that should stay running → a **Deployment**. Reach for a
  ReplicaSet directly only when you specifically don't want rolling-update behavior
  (uncommon).

## Labels and selectors tie it together

`spec.selector.matchLabels` (ReplicaSet/Deployment) must match `spec.template.metadata.
labels` — this is how the controller finds "its" Pods among everything else in the
namespace. The same label (`app: nginx` in these examples) is also what
`examples/services/sample-service.yaml`'s `spec.selector` matches on — see
`03-services-and-networking.md`.
