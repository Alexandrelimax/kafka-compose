import logging
from fastapi import HTTPException, status
from app.controllers.base_controller import BaseController
from app.services.mercado_livre_service import MercadoLivreService
from app.services.kafka_producer_service import KafkaProducerService



class MercadoLivreController(BaseController):
    def __init__(self, service: MercadoLivreService, producer_service: KafkaProducerService):
        self.service = service
        self.producer_service = producer_service
        super().__init__(prefix="/mercado_livre")

    def register_routes(self):
        self.router.add_api_route("/", self.get_offers, methods=["GET"], response_model=dict)


    def get_offers(self) -> dict:
        try:
            products = self.service.fetch_all_offers()
            
            self.producer_service.send_batch(products)

            return {"status": "success", "message": f"{len(products)} produtos enviados ao Kafka."}
        
        except Exception as e:
            logging.error(f"Erro ao enviar produtos: {str(e)}")
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(e))
             
             
