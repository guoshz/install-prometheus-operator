#!/bin/bash
set -e

MyImageRepositoryIP=192.168.9.20
MyImageRepositoryProject=library
MyImageRepositoryUser="admin"
MyImageRepositoryPassword="Harbor12345"

PrometheusOperatorVersion=0.23.2

docker load -i ../../offline-files/images/prometheus-operator-images-v0.23.2.tar

docker login -u $MyImageRepositoryUser -p $MyImageRepositoryPassword $MyImageRepositoryIP

for file in $(cat images-list.txt); do docker tag $file $MyImageRepositoryIP/$MyImageRepositoryProject/${file##*/}; done

echo 'Images taged.'

for file in $(cat images-list.txt); do docker push $MyImageRepositoryIP/$MyImageRepositoryProject/${file##*/}; done

echo 'Images pushed.'
