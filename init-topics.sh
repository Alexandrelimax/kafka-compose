#!/bin/bash

KAFKA_HOST="localhost:9092"
TOPIC_NAME="deal-of-the-day"

echo "Creating Kafka topic: $TOPIC_NAME"

kafka-topics --create \
  --bootstrap-server $KAFKA_HOST \
  --replication-factor 2 \
  --partitions 3 \
  --topic $TOPIC_NAME

echo "Topic $TOPIC_NAME created successfully!"
