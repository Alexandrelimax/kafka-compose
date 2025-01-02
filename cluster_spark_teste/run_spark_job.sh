#!/bin/bash

JOB_FILE="/app/spark_job.py"

SPARK_SUBMIT_PATH="/opt/bitnami/spark/bin/spark-submit"

CONTAINER_NAME="spark-master"

echo "Iniciando execução do job Spark dentro do container $CONTAINER_NAME..."

docker exec -it $CONTAINER_NAME $SPARK_SUBMIT_PATH \
  --master spark://spark-master:7077 \
  --deploy-mode client \
  --jars /opt/bitnami/spark/jars/commons-pool2-2.11.1.jar,\
  /opt/bitnami/spark/jars/spark-token-provider-kafka-0-10_2.12-3.5.1.jar,\
  /opt/bitnami/spark/jars/gcs-connector-hadoop3-2.2.12-shaded.jar,\
  /opt/bitnami/spark/jars/spark-3.5-bigquery-0.41.1.jar,\
  /opt/bitnami/spark/jars/spark-sql-kafka-0-10_2.12-3.5.1.jar,\
  /opt/bitnami/spark/jars/kafka-clients-3.5.1.jar \
  $JOB_FILE

# Verifica o status da execução do job
if [ $? -eq 0 ]; then
  echo "Job executado com sucesso!"
else
  echo "Falha ao executar o job."
  exit 1
fi
