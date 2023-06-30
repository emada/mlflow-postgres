# MLflow docker containers integrated with Postgres and MinIO

##
MLflow tracking server is configured following [Scenario 5: MLflow Tracking Server enabled with proxied artifact storage access](https://mlflow.org/docs/2.4.1/tracking.html#scenario-5-mlflow-tracking-server-enabled-with-proxied-artifact-storage-access). This allows us to use MLflow without worrying about MinIO credentials.

## How to install
Create a *.env* file containing the needed environment variables. You can use *sample.env* as a starting point.

Install the MLflow service using
```bash
sudo ./install.sh
```
The installer will start the MLflow service and ensure it starts whenever the system boots, with `systemctl enable mlflow`. The first time the service runs, it will pull and build the necessary docker images. Therefore it will take a couple of minutes to start.

If you keep the default port numbers, you can reach
- Mlflow UI at [127.0.0.1:5000](http://127.0.0.1:5000)
- Postgres at [127.0.0.1:5432](http://127.0.0.1:5432)
- MinIO UI at [127.0.0.1:19090](http://127.0.0.1:19090)

I've chosen ports 19090 and 19000 for MinIO's Console and API instead of the defaults 9090 and 9000, as VS Code's Remote - SSH extension uses port 9000. By the way, you may need to do a port forward if deploying to a remote server.

## How to use
To access the model or any other artifact, you'll need set the MLflow tracking server's URI and use something like below

```python
import mlflow

s3_bucket = 'mlflow-artifacts'
run_id = '12d591bf1e3a4f2aaed1dce7b9553c9f'

mlflow.set_tracking_uri("http://127.0.0.1:5000")

logged_model_1 = f'runs:/{run_id}/model'
logged_model_2 = f'{S3_BUCKET}:/1/{run_id}/artifacts/model'

# Load model as a PyFuncModel
loaded_model_1 = mlflow.pyfunc.load_model(logged_model_1)
loaded_model_2 = mlflow.pyfunc.load_model(logged_model_2)
```

If you need to bypass the MLflow tracking server and access the model in the S3 bucket directly, you'll need to slightly change the model's URL and set both your S3 endpoint and your MinIO's credentials. The following example accomplishes it 

```python
import mlflow
import os

os.environ['AWS_ACCESS_KEY_ID'] = 'mlflow_access_key'
os.environ['AWS_SECRET_ACCESS_KEY'] = 'mlflow_secret_key'
os.environ['MLFLOW_S3_ENDPOINT_URL'] = 'http://127.0.0.1:19000'

s3_bucket = 'mlflow-artifacts'
run_id = '12d591bf1e3a4f2aaed1dce7b9553c9f'

logged_model_3 = f's3://{s3_bucket}/1/{run_id}/artifacts/model'

# Load model as a PyFuncModel
loaded_model_3 = mlflow.pyfunc.load_model(logged_model_3)
```

You can also add the environment variables to your bash profile, so you don't have to add them to your python code

```bash
export AWS_ACCESS_KEY_ID=mlflow_access_key
export AWS_SECRET_ACCESS_KEY=mlflow_secret_key
export MLFLOW_S3_ENDPOINT_URL=http://127.0.0.1:19000
```

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
- https://github.com/pandego/mlflow-postgres-minio
