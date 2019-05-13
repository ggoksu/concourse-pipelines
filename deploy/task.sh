#!/bin/bash

set -xu

curl -L https://s3.amazonaws.com/mevansam-software/pivotal/kubectl -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

curl -L https://s3.amazonaws.com/mevansam-software/pivotal/pks -o /usr/local/bin/pks
chmod +x /usr/local/bin/pks

pks login --skip-ssl-validation \
  --api $PKS_API_ENDPOINT \
  --username $PKS_USERNAME \
  --password $PKS_PASSWORD

echo $PKS_PASSWORD | pks get-credentials $PKS_CLUSTER_NAME
kubectl config use-context $PKS_CLUSTER_NAME

kubectl get namespace "$ENVIRONMENT" >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  cat << ---EOF > namespace.yml
apiVersion: v1
kind: Namespace
metadata:
  name: $ENVIRONMENT
---EOF

  set -e
  kubectl create -f namespace.yml
  set +e
fi
kubectl config set-context $PKS_CLUSTER_NAME --namespace=$ENVIRONMENT

kubectl get secret harbor-cred >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  
  set -e
  kubectl create secret docker-registry harbor-cred \
    --docker-server=$DOCKER_REGISTRY_SERVER \
    --docker-username=$DOCKER_REGISTRY_USERNAME \
    --docker-password=$DOCKER_REGISTRY_PASSWORD
  set +e
fi

export VERSION=$(cat registry/tag)
export IMAGE_REPOSITORY=$(cat registry/repository)
echo "Deploying $IMAGE_REPOSITORY version $VERSION to $ENVIRONMENT."

eval "echo \"$(cat $DEPLOYMENT_MANIFEST)\"" > deployment.yml

kubectl apply -f deployment.yml -n $ENVIRONMENT
#kubectl apply -f $DEPLOYMENT_MANIFEST -n $ENVIRONMENT

