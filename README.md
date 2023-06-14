# MLflow tracking server with Postgres and MinIO backend

## How to use
Create a *.env* file containing the needed environment variables. You can use *sample.env* as a starting point.

Install the MLflow service using
```
sudo ./install.sh
```
The installer will start the MLlfow service and make sure it starts whenever the system boots, with `systemctl enable mlflow`. The first time the service runs it will pull and build the necessary docker images. Therefore it will take a couple of minutes to start.

If you keep the default port numbers you can reach
- Mlflow UI at [127.0.0.1:5000](http://127.0.0.1:5000)
- Postgres at [127.0.0.1:5432](http://127.0.0.1:5432)
- MinIO UI at [127.0.0.1:19090](http://127.0.0.1:19090)

You may need to do a port forward if deploying to a remote server

## Links
- [MLflow 2.4.1 docs](https://mlflow.org/docs/2.4.1/index.html)
- [PostgreSQL 15 docs](https://www.postgresql.org/docs/15/index.html)
- [MinIO docs](https://min.io/docs/minio/container/index.html)

## Inspired by
- https://github.com/bubulmet/mlflow-postgres-minio/tree/main
- https://github.com/ekity1002/docker-mlflow-postgres-minio
- https://gist.github.com/mosquito/b23e1c1e5723a7fd9e6568e5cf91180f
- https://bertptrs.nl/2021/09/05/securely-passing-secrets-to-dynamicuser-systemd-services.html
- https://dev.to/darnahsan/how-to-make-systemd-have-access-to-environment-variables-583b
