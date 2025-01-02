import logging
import uuid
from app.scraper.mercado_livre_scraper import MercadoLivreScraper


class MercadoLivreService:
    def __init__(self, base_url: str, scraper: MercadoLivreScraper):
        self.scraper = scraper
        self.base_url = base_url
        
    def fetch_offers(self) -> list[str]:
        """Obtém os links das ofertas do dia."""
        soup = self.scraper.get_page_content(self.base_url)
        links = []
        
        for item in soup.find_all("div", class_="andes-card poly-card poly-card--grid-card andes-card--flat andes-card--padding-0 andes-card--animated"):
            link = item.find("a", class_="poly-component__title")["href"]
            if link:
                links.append(link)
        return links


    def fetch_product_details(self, link: str) -> dict:
        soup = self.scraper.get_page_content(link)

        name = soup.find("h1", class_="ui-pdp-title").get_text(strip=True)

        product_evaluation = soup.find("span", class_="ui-pdp-review__rating")
        product_evaluation = product_evaluation.get_text(strip=True) if product_evaluation else "No evaluation"

        quantity_evaluation = soup.find("span", class_="ui-pdp-review__amount")
        quantity_evaluation = quantity_evaluation.get_text(strip=True) if quantity_evaluation else "No evaluation"

        price = soup.find("meta", itemprop='price')['content']
        
        tables_features = soup.find_all("table", class_="andes-table")
        product_features = self.format_product_features(tables_features)

        seller_button = soup.find("button", class_="ui-pdp-seller__link-trigger-button")
        seller = seller_button.get_text(strip=True) if seller_button else "No seller information"

        description = soup.find("p", class_="ui-pdp-description__content")
        description = description.get_text(strip=True) if description else "No description available"

        return {
            "id": uuid.uuid4().hex,
            "name": name,
            "product_evaluation": product_evaluation,
            "quantity_evaluation": quantity_evaluation,
            "price": price,
            "product_features": product_features,
            "seller": seller,
            "description": description,
            "link": link,
            "ecommerce": "Mercado Livre"
        }

    def fetch_all_offers(self) -> list[dict]:
        links = self.fetch_offers()
        products = []
        for link in links:
            try:
                product = self.fetch_product_details(link)
                products.append(product)
            except Exception as e:
                logging.error(f"Erro ao coletar detalhes do produto no link '{link}': {str(e)}")

        return products
    

    def format_product_features(self, tables) -> str:
        formatted_features = []
        for table in tables:
            rows = table.find("tbody").find_all("tr", class_="andes-table__row")
            for row in rows:
                key = row.find("th").get_text(strip=True)
                value = row.find("td").get_text(strip=True)
                formatted_features.append(f"- {key}: {value}")

        if formatted_features:
            return "Características Técnicas:\n" + "\n".join(formatted_features)
        return "Características Técnicas:\n- No features available"