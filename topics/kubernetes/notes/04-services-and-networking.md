# Services and networking

Pods are ephemeral — each gets a new IP when recreated. A **Service** gives a stable
address in front of a changing set of Pods, found by label selector (the same mechanism a
Deployment uses to find its Pods, see `02-pods-and-workloads.md`).

## How it wires up

```yaml
# examples/services/sample-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: sample-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```

```bash
kubectl apply -f examples/services/sample-service.yaml
kubectl apply -f examples/deployment/sample-deployment.yaml   # labels app: nginx — matches the selector above
kubectl get endpoints sample-service     # the actual Pod IPs the Service currently routes to
kubectl run curl --rm -i --restart=Never --image=curlimages/curl -- curl -s sample-service
```

`spec.selector` matches Pods by label, exactly like a Deployment's selector — any Pod
labeled `app: nginx`, from any controller, becomes a backend automatically. `port` is what
callers connect to; `targetPort` is the container port it's forwarded to (they can differ,
e.g. exposing `80` in front of a container listening on `8080`, as
`deployment-with-security-context.yaml` does). If `kubectl get endpoints` shows no
addresses, the selector doesn't match any running Pod's labels — the most common Service
misconfiguration.

## Service types

| Type | Reachable from | Use |
| --- | --- | --- |
| `ClusterIP` (default) | inside the cluster only | service-to-service traffic; this repo's example |
| `NodePort` | any node's IP, on a fixed high port (30000-32767) | quick external access without a cloud LB |
| `LoadBalancer` | the internet, via a cloud provider's LB | production external access (cloud clusters only) |
| `ExternalName` | inside the cluster, resolves to a `CNAME` | aliasing an external DNS name into cluster DNS |

## DNS

Every Service gets a cluster-DNS name: `<service>.<namespace>.svc.cluster.local`, usually
just `<service>` from within the same namespace. That's why the curl test above targets
`sample-service` directly, no IP needed — this repo's own CI (`k8s-kind` job) does the
exact same curl to confirm the Deployment and Service are wired correctly end to end.

## Ingress (not in this repo's examples, worth knowing)

A Service (even `LoadBalancer`) is one IP/port per Service. An **Ingress** sits in front
of many Services and routes by hostname/path over HTTP(S), needs an ingress controller
installed in the cluster to do anything, and is the usual answer to "route
`api.example.com` and `app.example.com` to different Services on one IP".
