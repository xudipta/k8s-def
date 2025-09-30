# k8s-def
## k8s-def

A quick reference repository for Kubernetes definition files. This repo organizes common Kubernetes resources into separate folders for easy access and sharing.

## Structure

- `pod/` — Pod definitions
- `deployment/` — Deployment definitions
- `services/` — Service definitions
- `configs/` — ConfigMap definitions
- `secrets/` — Secret definitions

Each folder contains sample YAML files to help you get started:

- `pod/sample-pod.yaml`
- `deployment/sample-deployment.yaml`
- `services/sample-service.yaml`
- `configs/sample-configmap.yaml`
- `secrets/sample-secret.yaml`

## Usage

1. Browse the folders for sample YAML files.
2. Copy and modify the files as needed for your own Kubernetes resources.
3. Apply files using `kubectl apply -f <file>`.

## Example

```bash
kubectl apply -f pod/sample-pod.yaml
```

Feel free to add more examples or customize the files for your use case.
