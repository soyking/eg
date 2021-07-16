#!/bin/bash -ex

source config.var

docker push $docker_tag
