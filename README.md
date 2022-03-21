# dcm-viewer-in-kind
viewer on k8s experiments.

This Repo will help you setup a OHIF+DCM4CHEE on a KinD cluster for experiments.

**NOTE:** Currently only have minimum setups for dcm4chee.

## Prerequisites
- [Docker](https://www.docker.com/get-started/) is installed
- [KinD](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) is installed
## Deploy Local
Use the following command will setup a KinD cluster, and deploy the resources onto the cluster. Note: KinD is required to be installed:
```
./scripts/start.sh
```

A sample test data set from `dcm4che/dcm4che-tools` will be be loaded.

OHIF UI: http://localhost:8888

DCM4CHEE UI: http://localhost:8888

After the experiments, you can cleanup the cluster with the following ocmmand:
```
kind delete cluster --name ohif-dcm4chee
```

## Reference
- https://gitlab.com/flywheel-io/public/ohif-viewer/-/tree/master/helm/ohif-viewer
- https://github.com/dcm4che/dcm4chee-arc-light/wiki/Deploy-Docker-Images-to-Kubernetes
- https://github.com/dcm4che/dcm4chee-arc-light/wiki/Run-minimum-set-of-archive-services-on-a-single-host
- https://github.com/jonasscherer/namic_project_week_30 

## TODO
- [ ] Add ingress
- [ ] Add keycloak
- [ ] PV support
- [ ] Support remote k8s deployment