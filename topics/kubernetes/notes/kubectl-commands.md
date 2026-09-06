# Common kubectl commands

Useful `kubectl` commands for creating, editing, extracting, and redeploying resource
definitions.

## Create resources

Create a new resource:

```bash
kubectl create -f <file>.yaml
```

Create or update a resource:

```bash
kubectl apply -f <file>.yaml
```

## Edit resources

```bash
kubectl edit <resource-type> <resource-name>
# e.g. kubectl edit deployment my-deployment
```

## Extract an existing Pod definition

```bash
kubectl get pod <pod-name> -o yaml > pod-definition.yaml
```

## Redeploy from an extracted definition

```bash
kubectl delete pod <pod-name>
kubectl apply -f pod-definition.yaml
```

## Other useful commands

```bash
kubectl get pods                                   # list pods
kubectl describe <resource-type> <resource-name>   # inspect a resource
kubectl logs <pod-name>                            # view container logs
```
