from confluent_kafka import Producer
import uuid
import json
import logging


class KafkaProducerService:
    def __init__(self, bootstrap_servers: str, topic: str):
        self.topic = topic
        self.producer = Producer({'bootstrap.servers': bootstrap_servers})

    def send_message(self, message: str):
        #Envia mensagem individual para o Kafka.
        try:
            key = uuid.uuid4().hex

            self.producer.produce(
                self.topic,
                key=key,
                value=json.dumps(message),
                callback=self._delivery_report
            )
            self.producer.flush()
        except Exception as e:
            logging.error(f"Erro ao enviar mensagem para o Kafka: {str(e)}")


    def send_batch(self, messages: list[dict]):
        #Envia mensagens em lote para o Kafka.
        for message in messages:
            try:           
                self.producer.produce(
                    self.topic,
                    key=message["id"],
                    value=json.dumps(message),
                    callback=self._delivery_report
                )
            except Exception as e:
                logging.error(f"Erro ao enviar mensagem: {str(e)}")

        self.producer.flush()


    def send_batch_as_single_message(self, messages: list[dict]):
        #Envia a lista inteira como uma única mensagem JSON.
        try:
            batch_message = json.dumps(messages)
            
            self.producer.produce(
                self.topic,
                key="batch_key",
                value=batch_message,
                callback=self._delivery_report
            )
            self.producer.flush()
        except Exception as e:
            logging.error(f"Erro ao enviar lote como uma única mensagem: {str(e)}")


    def _delivery_report(self, err, msg):
        #Callback para status de entrega de mensagens.
        if err is not None:
            logging.error(f"Erro ao enviar mensagem: {err}")
        else:
            logging.info(f"Mensagem enviada com sucesso para {msg.topic()} [{msg.partition()}]")