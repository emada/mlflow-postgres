#!/bin/bash

INSTALL_DIR=/etc/docker/compose/mlflow

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

rm -f /etc/systemd/system/mlflow.service
cp mlflow.service /etc/systemd/system/mlflow.service

rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}
cp .env ${INSTALL_DIR}
cp docker-compose.yml ${INSTALL_DIR}
cp mlflow.Dockerfile ${INSTALL_DIR}
cp README.md ${INSTALL_DIR}
cp requirements.txt ${INSTALL_DIR}

echo "MLflow service successfully installed!"
echo "You can now delete this installation folder including the .env file."

systemctl daemon-reload
systemctl enable mlflow

echo "I'll start MLflow now."
systemctl start mlflow
echo "It'll take a couple of minutes to load the service as the system will pull and build the necessary docker images."
echo "Use 'journalctl -fu mlflow' to see MLflow's installation status."
