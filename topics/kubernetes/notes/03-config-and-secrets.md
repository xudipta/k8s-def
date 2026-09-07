# ConfigMaps and Secrets

Both decouple configuration from the container image; the only real difference is intent
and encoding — Secrets are for sensitive values and are base64-encoded (not encrypted) at
rest by default.

## ConfigMap

```yaml
# examples/configs/sample-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: sample-config
  namespace: default
data:
  key1: value1
  key2: value2
```

```bash
kubectl apply -f examples/configs/sample-configmap.yaml
kubectl get configmap sample-config -o yaml
kubectl create configmap inline-config --from-literal=key1=value1   # equivalent, no file
kubectl create configmap file-config --from-file=app.conf            # one key per file, keyed by filename
```

## Secret

```yaml
# examples/secrets/sample-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: sample-secret
stringData:
  username: admin
  password: secret123
```

```bash
kubectl apply -f examples/secrets/sample-secret.yaml
kubectl get secret sample-secret -o jsonpath='{.data.username}' | base64 -d
```

`stringData` (plaintext in the manifest) is a convenience — the API server writes it into
`data` **base64-encoded** on save; `kubectl get -o yaml` afterwards shows only the encoded
`data` form. Base64 is encoding, not encryption: anyone who can `kubectl get secret -o
yaml` can read it. Real secrecy comes from RBAC restricting who can read Secrets, and
(for at-rest protection) enabling [encryption at
rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/) on the cluster,
or using an external secret store — don't commit real Secret manifests to git, including
in this repo's own `examples/` (`sample-secret.yaml`'s values are dummy, for the `kind`
CI smoke test only).

## Consuming them: env vars vs. volume mounts

`examples/pod/pod-with-configmap-secret.yaml` and
`examples/deployment/deployment-with-configmap-secret.yaml` show both patterns on the
same Pod spec:

```yaml
env:
  - name: CONFIG_KEY1
    valueFrom:
      configMapKeyRef: { name: sample-config, key: key1 }
  - name: SECRET_USERNAME
    valueFrom:
      secretKeyRef: { name: sample-secret, key: username }
volumeMounts:
  - name: config-volume
    mountPath: /etc/config
  - name: secret-volume
    mountPath: /etc/secret
volumes:
  - name: config-volume
    configMap: { name: sample-config }
  - name: secret-volume
    secret: { secretName: sample-secret }
```

```bash
kubectl apply -f examples/pod/pod-with-configmap-secret.yaml
kubectl exec pod-with-configmap-secret -- env | grep -E 'CONFIG_KEY1|SECRET_USERNAME'
kubectl exec pod-with-configmap-secret -- ls /etc/config /etc/secret
```

- **Env vars** (`valueFrom`) — simplest, but only read once at container start; updating
  the ConfigMap/Secret does **not** update an already-running container's environment.
- **Volume mounts** — each key becomes a file under the mount path; kubelet periodically
  syncs the mounted files when the source ConfigMap/Secret changes (Secrets mounted this
  way update within roughly a minute), so an app that watches its config file for changes
  can pick up updates without a restart. `kubectl rollout restart` (see
  `01-kubectl-commands.md`) is the reliable way to force a restart either way.
