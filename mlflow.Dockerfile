# Adapted from
# https://github.com/bubulmet/mlflow-postgres-minio/blob/main/Dockerfile

FROM python:3.11-slim

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
