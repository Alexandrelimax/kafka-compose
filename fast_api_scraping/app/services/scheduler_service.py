from apscheduler.schedulers.background import BackgroundScheduler
import requests
import logging


class SchedulerService:
    def __init__(self, endpoint_url: str, interval_minutes: int = 30):
        self.endpoint_url = endpoint_url
        self.interval_minutes = interval_minutes
        self.scheduler = BackgroundScheduler()

    def trigger_crawler(self):
        #Dispara o endpoint do crawler.
        try:
            response = requests.post(self.endpoint_url)
            logging.info(f"Crawler acionado! Status: {response.status_code}")
        except Exception as e:
            logging.error(f"Erro ao acionar o crawler: {str(e)}")

    def start(self):
        #Inicia o agendador.
        try:
            self.scheduler.add_job(
                self.trigger_crawler,
                "interval",
                minutes=self.interval_minutes,
                id="crawler_job",
                replace_existing=True,
            )
            self.scheduler.start()
            logging.info("Agendador iniciado!")
        except Exception as e:
            logging.error(f"Erro ao iniciar o agendador: {str(e)}")

    def stop(self):
        #Finaliza o agendador.
        try:
            self.scheduler.shutdown()
            logging.info("Agendador finalizado!")
        except Exception as e:
            logging.error(f"Erro ao finalizar o agendador: {str(e)}")