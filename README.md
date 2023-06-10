# MLflow tracking server with Postgres backend for Ubuntu 22.04

> Inspired by:
- [this](https://github.com/bubulmet/mlflow-postgres-minio/tree/main)
- [this](https://gist.github.com/mosquito/b23e1c1e5723a7fd9e6568e5cf91180f)
- [this](https://bertptrs.nl/2021/09/05/securely-passing-secrets-to-dynamicuser-systemd-services.html)
- [this](https://dev.to/darnahsan/how-to-make-systemd-have-access-to-environment-variables-583b)

**Links:**
- [MLflow docs](https://mlflow.org/docs/latest/index.html)
- [PostgreSQL on DockerHub](https://hub.docker.com/_/postgres)

**How to use**
1. Create a .env file containing the environment variables like below
- export DB_NAME=mlflowdb
- export DB_USER=postgres
- export DB_PW=<your_password>
- export DB_PORT=5432
- export MLFLOW_PORT=5001
2. Install the MLflow service using
`sudo ./install.sh`
3. Start your MLflow service with
`systemctl start docker-compose@mlflow`
4. You can reach
- Mlflow UI at [127.0.0.1:5001](http://127.0.0.1:5001) or any other port number you chose
- database at [127.0.0.1:5432](http://127.0.0.1:5432) or any other port number you chose
5. You will need to do a port forward if deploying to a remote server
