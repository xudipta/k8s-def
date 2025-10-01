# k8s-def
## k8s-def

A quick reference repository for Kubernetes definition files. This repo organizes common Kubernetes resources into separate folders for easy access and sharing.


## Structure

- `pod/` — Pod definitions
- `deployment/` — Deployment definitions
- `replicaset/` — ReplicaSet definitions
- `services/` — Service definitions
- `configs/` — ConfigMap definitions
- `secrets/` — Secret definitions

## Usage

1. Browse the folders for sample YAML files.
2. Copy and modify the files as needed for your own Kubernetes resources.
3. Apply files using `kubectl apply -f <file>`.

## Examples

Apply a Pod definition:
```bash
kubectl apply -f pod/sample-pod.yaml
```

Apply a Deployment with ConfigMap and Secret:
```bash
kubectl apply -f deployment/deployment-with-configmap-secret.yaml
```

Apply a Pod with SecurityContext:
```bash
kubectl apply -f pod/pod-with-security-context.yaml
```

Apply a Deployment with SecurityContext:
```bash
kubectl apply -f deployment/deployment-with-security-context.yaml
```

## SecurityContext Usage

You can use `securityContext` in both Pods and Deployments:

- **Pod-level securityContext**: Set under `spec.securityContext` (applies to all containers in the Pod).
- **Container-level securityContext**: Set under `spec.containers[].securityContext` (applies only to the specific container).

See the example files for both usages.

## ConfigMap and Secret Usage

ConfigMaps and Secrets can be injected into Pods and Deployments as environment variables or mounted as volumes. Example files demonstrate both approaches.

Feel free to add more examples or customize the files for your use case.
