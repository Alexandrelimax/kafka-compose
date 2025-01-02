#!/bin/bash

topic_name="deal-of-the-day"
broker="kafka-1:9092"

echo "Criando o tópico '$topic_name' no broker $broker..."
docker exec kafka-1 /opt/bitnami/kafka/bin/kafka-topics.sh --create \
  --bootstrap-server $broker \
  --replication-factor 3 \
  --partitions 3 \
  --topic $topic_name


echo "Obtendo descrição do tópico '$topic_name'..."
docker exec kafka-1 /opt/bitnami/kafka/bin/kafka-topics.sh --describe \
  --bootstrap-server $broker \
  --topic $topic_name
