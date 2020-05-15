# kubectl in Docker

![pulls](https://img.shields.io/docker/pulls/7val/kubectl.svg)
![size](https://images.microbadger.com/badges/image/7val/kubectl.svg)
[![commit](https://images.microbadger.com/badges/commit/7val/kubectl.svg)](https://microbadger.com/images/7val/kubectl)

Can run any kubectl command. Contains the latest version of kubectl and is based
on the debian:stable-slim image.

The kubectl configuration is set via environment variables and is written inside
the container.

## Variables/configuration

Mandatory for connecting to a K8s cluster:
* KUBECTL_CLUSTER_URL: URL of the K8s cluster which kubectl will contact.
* KUBECTL_TOKEN: Token which kubectl uses to connect with the k8s cluster.
* KUBECTL_NAMESPACE: K8s namespace kubectl will work on.
* KUBECTL_CLUSTER_NAME: Name of the k8s cluster.

Optional:
* KUBECTL_ENTRYPOINT_TRACE: Enable Shell debug mode
* CONFIGURE_KUBECTL: If "true" it writes a kubectl configuration file inside the
  container so that a K8s cluster can be connected. Values: true/false, default
  true.
