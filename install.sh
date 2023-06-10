#!/bin/bash

INSTALL_DIR=/etc/docker/compose/mlflow

rm -f /etc/systemd/system/docker-compose@.service
cp docker/docker-compose@.service /etc/systemd/system/docker-compose@.service

rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}
cp README.md ${INSTALL_DIR}
cp .env ${INSTALL_DIR}
cp docker/docker-compose.yml ${INSTALL_DIR}
cp docker/Dockerfile ${INSTALL_DIR}
cp docker/requirements.txt ${INSTALL_DIR}

echo "[ OK ] MLflow service successfully installed!"
echo "Use 'systemctl start docker-compose@mlflow' to start it"
