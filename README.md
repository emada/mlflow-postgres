# MLflow tracking server with Postgres and MinIO backend for Ubuntu 22.04

**How to use**
1. Create a .env file containing the environment variables like below
```
export DB_NAME=mlflowdb
export DB_USER=postgres
export DB_PW=<your_password>
export DB_PORT=5432
export MLFLOW_PORT=5001
```

docker-compose up -d
on MinIO create a bucket named mlflow-artifacts. It is possible in the browser, at 127.0.0.1:9000 (you need it once, then it will be saved in volume)
when accessing MLflow from python, you need to define environment variables:
    MLFLOW_S3_ENDPOINT_URL=http://127.0.0.1:9000
    ARTIFACT_ROOT=s3://mlflow-artifacts/
    AWS_ACCESS_KEY_ID=mlflow_access_key
    AWS_SECRET_ACCESS_KEY=mlflow_secret_key


2. Install the MLflow service using
```
sudo ./install.sh
```

3. Finally, use the enable command to ensure that the service starts whenever the system boots
```
systemctl enable mlflow
```
4. Start your MLflow service if not on
```
systemctl start mlflow
```

5. You can reach
- Mlflow UI at [127.0.0.1:5001](http://127.0.0.1:5001) or any other port number you chose
- database at [127.0.0.1:5432](http://127.0.0.1:5432) or any other port number you chose
6. You will need to do a port forward if deploying to a remote server

**Links**
- [MLflow docs](https://mlflow.org/docs/latest/index.html)
- [PostgreSQL on DockerHub](https://hub.docker.com/_/postgres)

**Inspired by**
- https://github.com/bubulmet/mlflow-postgres-minio/tree/main
- https://github.com/ekity1002/docker-mlflow-postgres-minio
- https://gist.github.com/mosquito/b23e1c1e5723a7fd9e6568e5cf91180f
- https://bertptrs.nl/2021/09/05/securely-passing-secrets-to-dynamicuser-systemd-services.html
- https://dev.to/darnahsan/how-to-make-systemd-have-access-to-environment-variables-583b