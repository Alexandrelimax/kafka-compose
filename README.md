# **Projeto Kafka-Compose: Scraping, Kafka e BigQuery**

Este projeto é uma implementação prática de um pipeline de dados em tempo real que utiliza Kafka, Spark e BigQuery. O objetivo é realizar o scraping de ofertas do Mercado Livre, processar as informações usando Apache Kafka e Apache Spark, e armazenar os resultados no Google BigQuery.

---

## **Visão Geral**

O projeto realiza as seguintes etapas:
1. **Scraping** de ofertas promocionais da página de promoções do Mercado Livre.
2. **Envio dos dados ao Kafka** para distribuição eficiente das mensagens.
3. **Consumo dos dados pelo PySpark**, que realiza a transformação e processamento das mensagens.
4. **Armazenamento das ofertas processadas no BigQuery**, garantindo acessibilidade para análises futuras.

---

## **Arquitetura do Projeto**

A arquitetura do projeto é composta por quatro componentes principais:

1. **Scraper do Mercado Livre**:
   - Extrai as informações das promoções diárias, como nome, preço, descrição e link do produto.
   - Os dados são enviados como mensagens para o Kafka.

2. **Apache Kafka**:
   - Atua como o backbone da pipeline, gerenciando o tráfego de mensagens.
   - Configurado com 3 brokers, distribuindo as mensagens entre partições.

3. **PySpark Consumer**:
   - Consome as mensagens do Kafka em tempo real.
   - Realiza a transformação dos dados (ex.: conversão de tipos e validações).
   - Salva as mensagens processadas no BigQuery.

4. **Google BigQuery**:
   - Armazena os dados confiáveis das ofertas em uma tabela particionada.
   - Permite consultas SQL para análises e relatórios.

   **![Imagem da arquitetura](path/to/scraping_image.png)**

---

## **Fluxo de Trabalho**

1. **Scraper**
   - O scraper é implementado em Python e acessa a página de promoções do Mercado Livre.
   - Envia os dados formatados para o Kafka através de um producer FastAPI.

   **![Imagem do Scraping](path/to/scraping_image.png)**

2. **Producer Kafka**
   - Envia mensagens para o tópico `deal-of-the-day` no cluster Kafka.

3. **Kafka**
   - Distribui as mensagens entre as partições para garantir escalabilidade.

4. **PySpark Consumer**
   - Consome as mensagens do Kafka em microbatches.
   - Processa os dados e salva os resultados no BigQuery.

5. **BigQuery**
   - Os dados finais ficam armazenados na tabela `daily_offers`, disponíveis para consulta.

   **![Imagem do Pipeline](path/to/pipeline_image.png)**

---

## **Componentes do Projeto**

### **1. Scraper**
- **Local**: `fast_api_scraping/`
- Responsável por extrair dados da página de promoções.

### **2. Producer Kafka**
- **Local**: `fast_api_scraping/services/`
- Endpoint REST implementado com FastAPI para enviar mensagens ao Kafka.

### **3. Apache Kafka**
- **Local**: `cluster_kafka/`
- Configuração de 3 brokers para distribuir e replicar as mensagens.

### **4. PySpark Consumer**
- **Local**: `cluster_spark_teste/spark_job.py`
- Script que consome mensagens do Kafka e salva os dados no BigQuery.

### **5. Google BigQuery**
- Configuração do bucket e tabela no Terraform para armazenamento.

---

## **Infraestrutura**

A infraestrutura do projeto é provisionada no Google Cloud e gerenciada com Docker e Terraform:
- **Kafka**: Cluster Kafka rodando em instâncias de Compute Engine.
- **Spark (Teste)**: Apache Spark configurado em containers Docker, utilizado para desenvolvimento e validação local.
- **Spark (Produção)**: Executado no **Google Dataproc**, que gerencia clusters Spark escaláveis.
- **BigQuery**: Tabela particionada para armazenamento de dados confiáveis.
- **Terraform**: Gerenciamento da infraestrutura.



---

## **Como Executar**

### **1. Pré-requisitos**
- Google Cloud SDK configurado.
- Docker e Docker Compose instalados.
- Conta de serviço no Google Cloud com permissões para BigQuery e Storage.

### **2. Configurar Variáveis**
Crie um arquivo `.env`:
```env
TABLE_NAME=daily_offers
BUCKET_NAME=seu-bucket-checkpoints
GOOGLE_APPLICATION_CREDENTIALS=/caminho/para/service_account.json
