#!/bin/bash

DEV_CONTAINER_APISIX="apisix.saqal.dev"
DEV_CONTAINER_ETCD="etcd.dev"
QA_IMAGE_APISIX="apisix.saqal.qa:latest"
QA_IMAGE_ETCD="etcd.qa:latest"

echo "Committing containers from dev environment..."
docker commit $DEV_CONTAINER_APISIX $QA_IMAGE_APISIX
docker commit $DEV_CONTAINER_ETCD $QA_IMAGE_ETCD

echo "Updating QA environment..."
docker compose -f apisix-qa/qa-compose.yml down
sed -i '' "s|image:.*apisix-qa.*|image: $QA_IMAGE_APISIX|" apisix-qa/qa-compose.yml
sed -i '' "s|image:.*etcd.qa.*|image: $QA_IMAGE_ETCD|" apisix-qa/qa-compose.yml
docker compose -f apisix-qa/qa-compose.yml up -d
make -f apisix-qa/Makefile dashbaord
echo "QA environment updated with latest changes!"