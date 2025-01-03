import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json
from pyspark.sql.types import StructType, StructField, StringType, FloatType

table_name = os.environ.get("TABLE_NAME")
bucket_name = os.environ.get("BUCKET_NAME")

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/app/service_account.json"

spark = SparkSession.builder \
    .appName("KafkaToBigQueryPipeline") \
    .master("spark://spark-master:7077") \
    .config("spark.executor.memory", "2g") \
    .config("spark.executor.cores", "1") \
    .getOrCreate()

schema = StructType([
    StructField("id", StringType(), False),
    StructField("name", StringType(), True),
    StructField("product_evaluation", StringType(), True),
    StructField("quantity_evaluation", StringType(), True),
    StructField("price", FloatType(), True),
    StructField("product_features", StringType(), True),
    StructField("seller", StringType(), True),
    StructField("description", StringType(), True),
    StructField("link", StringType(), True),
    StructField("ecommerce", StringType(), True)
])

df = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "kafka-1:9092,kafka-2:9093,kafka-3:9094") \
    .option("subscribe", "deal-of-the-day") \
    .option("startingOffsets", "earliest") \
    .option("failOnDataLoss", "false") \
    .load()


df_parsed = df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)") \
    .select(from_json(col("value"), schema).alias("data")) \
    .select("data.*")


def write_to_bigquery(batch_df, batch_id):
    try:
        batch_df.write \
            .format("bigquery") \
            .option("table", table_name) \
            .option("writeMethod", "direct") \
            .mode("append") \
            .save()
        print(f"Batch {batch_id} gravado com sucesso no BigQuery.")
    except Exception as e:
        print(f"Erro ao gravar o batch {batch_id} no BigQuery: {e}")


query = df_parsed.writeStream \
    .foreachBatch(write_to_bigquery) \
    .outputMode("append") \
    .option("checkpointLocation", f"gs://{bucket_name}/checkpoints/kafka_to_bigquery/") \
    .start()


query.awaitTermination()