# 🥘 Kube-Cookbook PR Recipe

## Recipe Name
Give your PR a tasty title, e.g., `Add sample nginx deployment`.

## Ingredients (What’s Changing)
List the main items you are adding, modifying, or removing, e.g.:
- Deployment YAML for `nginx`
- ConfigMap for sample app
- Secrets for credentials

## Instructions (Motivation / Why)
Explain why you cooked up these changes. What problem does it solve?  
Example: *“Added a sample deployment to demonstrate end-to-end service connectivity tests.”*

## Taste Test (Testing Instructions)
How to test your changes in the cluster:
- `kubectl apply -f deployment/`
- `kubectl apply -f services/`
- `kubectl get pods,svc -o wide`
- Optional: `kubectl run curl --rm -i --restart=Never --image=curlimages/curl:latest -- curl -s sample-service:80`

## Recipe Type
- [ ] App Deployment
- [ ] ConfigMap / Secretv
- [ ] Service / Networking
- [ ] Documentation
- [ ] Other

## Chef’s Notes (Additional Info)
Anything else reviewers should know. Examples:
- Dependencies on other PRs  
- Known issues / limitations  
- Tips for reviewers  
