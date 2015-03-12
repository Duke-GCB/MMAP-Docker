#!/bin/bash

OWNER=dleehr
for IMAGE in `ls`; do
  if [ -f $IMAGE/Dockerfile ]; then
    echo "Pushing $IMAGE to Docker Hub"
    docker push $OWNER/$IMAGE
  fi
done