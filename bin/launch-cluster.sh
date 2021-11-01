#!/bin/bash
k3d cluster delete wefox-challenge-cluster
k3d cluster create --config ./config/wefox-challenge-cluster.yml