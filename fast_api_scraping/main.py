import os

import uvicorn
from fastapi import FastAPI
from contextlib import asynccontextmanager
from dotenv import load_dotenv

from app.services.scheduler_service import SchedulerService
from app.scraper.mercado_livre_scraper import MercadoLivreScraper
from app.services.mercado_livre_service import MercadoLivreService
from app.controllers.mercado_livre_controller import MercadoLivreController
from app.services.kafka_producer_service import KafkaProducerService
load_dotenv(override=True)

HOST_KAFKA = os.getenv("HOST_KAFKA")

scraper = MercadoLivreScraper()

producer_service = KafkaProducerService(bootstrap_servers=f"{HOST_KAFKA}:9092", topic="deal-of-the-day")

mercado_livre_service = MercadoLivreService(scraper=scraper, base_url='https://www.mercadolivre.com.br/ofertas#nav-header')

mercado_livre_controller = MercadoLivreController(service=mercado_livre_service, producer_service=producer_service)


# @asynccontextmanager
# async def lifespan(app: FastAPI):
#     scheduler = SchedulerService(endpoint_url="http://127.0.0.1:8000/mercado-livre/", interval_minutes=30)
#     scheduler.start()
#     yield
#     scheduler.stop()

app = FastAPI(
    title="Mercado Livre Scraper",
    description="API para extração de dados do Mercado Livre",
    # lifespan=lifespan,  # Registrar o ciclo de vida
)

app.include_router(mercado_livre_controller.router)


@app.get("/")
def read_root():
    return {"message": "Teste API"}


# Comentar se for rodar no Docker
if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)