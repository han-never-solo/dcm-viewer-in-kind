#!/bin/bash -e
if [ ! -d output ]; then
  mkdir output
fi
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR="$SCRIPT_DIR/.."
export KUBECONFIG="$PROJECT_DIR/output/kind"

if ! kind get kubeconfig --name ohif-dcm4chee >/dev/null 2>/dev/null; then
  echo "starting kind cluster"
  kind create cluster --name ohif-dcm4chee --config "$PROJECT_DIR/kind/config.yaml"
fi

if ! helm get all ohif-dcm4chee --namespace ohif-dcm4chee >/dev/null 2>/dev/null; then
  echo "installing deployments"
  kubectl create ns ohif-dcm4chee || echo 'using existing namespace ohif-dcm4chee'
  helm install ohif-dcm4chee "$PROJECT_DIR/chart/ohif-dcm4chee" --namespace ohif-dcm4chee 
  kubectl rollout status deployment ohif-dcm4chee-arc -n ohif-dcm4chee
  kubectl rollout status deployment ohif-dcm4chee-ldap -n ohif-dcm4chee
  kubectl rollout status deployment ohif-dcm4chee-postgres -n ohif-dcm4chee
  echo "wait 60 seconds before loading data"
  sleep 60
  echo "loading test data"
  docker run --rm --network=host dcm4che/dcm4che-tools:5.25.2 storescu -cDCM4CHEE@localhost:11112 /opt/dcm4che/etc/testdata/dicom
else 
  helm upgrade ohif-dcm4chee "$PROJECT_DIR/chart/ohif-dcm4chee"
fi
