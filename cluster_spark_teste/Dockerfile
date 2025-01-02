FROM bitnami/spark:3.5.2

USER root

RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download das dependências necessárias
RUN curl -O https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/3.5.1/spark-sql-kafka-0-10_2.12-3.5.1.jar \
    && curl -O https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/3.5.1/kafka-clients-3.5.1.jar \
    && curl -O https://repo1.maven.org/maven2/org/apache/commons/commons-pool2/2.11.1/commons-pool2-2.11.1.jar \
    && curl -O https://storage.googleapis.com/spark-lib/bigquery/spark-3.5-bigquery-0.41.1.jar \
    && curl -O https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.12/gcs-connector-hadoop3-2.2.12-shaded.jar \
    && curl -O https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-0-10_2.12/3.5.1/spark-token-provider-kafka-0-10_2.12-3.5.1.jar

# Mover os arquivos JAR para o diretório de JARs do Spark
RUN mv spark-sql-kafka-0-10_2.12-3.5.1.jar \
       kafka-clients-3.5.1.jar \
       commons-pool2-2.11.1.jar \
       spark-3.5-bigquery-0.41.1.jar \
       gcs-connector-hadoop3-2.2.12-shaded.jar \
       spark-token-provider-kafka-0-10_2.12-3.5.1.jar \
       /opt/bitnami/spark/jars/

WORKDIR /app

COPY spark_job.py /app/spark_job.py
COPY run_spark_job.sh /app/run_spark_job.sh
COPY spark_job_teste.py /app/spark_job_teste.py

# Mudar para o usuário não root para maior segurança
USER 1001
