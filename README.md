Kube Router
============

[![](https://images.microbadger.com/badges/version/runningman84/kube-router.svg)](https://hub.docker.com/r/runningman84/kube-router "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/runningman84/kube-router.svg)](https://hub.docker.com/r/runningman84/kube-router "CGet your own image badge on microbadger.com")
[![](https://img.shields.io/docker/stars/runningman84/kube-router.svg)](https://hub.docker.com/r/runningman84/kube-router "Click to view the image on Docker Hub")
[![](https://img.shields.io/docker/pulls/runningman84/kube-router.svg)](https://hub.docker.com/r/runningman84/kube-router "Click to view the image on Docker Hub")
[![Anchore Image Overview](https://anchore.io/service/badges/image/4dff2e3b34b319e80705b6b0cb75cdb355a4a38ca5c9fa2556cc0cd384f6150a)](https://anchore.io/image/dockerhub/runningman84%2Fkube-router%3Alatest)

Introduction
----
This docker image provides a multi arch kube-router image. The offical image does not provide arm64 support yet:
https://github.com/cloudnativelabs/kube-router/issues/503
This image uses the docker multi-stage build feature in order to reduce the image size.

Install
----

In order to use this image instead of the offical image change the image setting in kubeadm-kuberouter-all-features.yaml from cloudnativelabs/kube-router to runningman84/kube-router

