# Common kubectl Commands

This file provides useful `kubectl` commands for working with Kubernetes resources, including creating, editing, extracting, and redeploying definitions.


## Create Resources

Create a new resource:
```bash
kubectl create -f <file>.yaml
```

Create or update a resource:
```bash
kubectl apply -f <file>.yaml
```

## Edit Resources

```bash
kubectl edit <resource-type> <resource-name>
# Example:
kubectl edit deployment my-deployment
```

## Extract Existing Pod Definition

```bash
kubectl get pod <pod-name> -o yaml > pod-definition.yaml
```

## Redeploy from Extracted Definition

```bash
kubectl delete pod <pod-name>
kubectl apply -f pod-definition.yaml
```

## Other Useful Commands

- List all pods:
  ```bash
  kubectl get pods
  ```
- Describe a resource:
  ```bash
  kubectl describe <resource-type> <resource-name>
  ```
- View logs:
  ```bash
  kubectl logs <pod-name>
  ```

Feel free to add more commands as needed for your workflow.
