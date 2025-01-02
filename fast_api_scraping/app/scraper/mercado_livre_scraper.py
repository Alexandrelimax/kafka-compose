import requests
from bs4 import BeautifulSoup

class MercadoLivreScraper:

    def get_page_content(self, url, headers=None):
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            return BeautifulSoup(response.content, "html.parser")
        else:
            raise Exception(f"Erro ao acessar a URL {url} (status: {response.status_code})")
