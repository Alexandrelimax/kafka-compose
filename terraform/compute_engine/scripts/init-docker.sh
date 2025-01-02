
#!/bin/bash
# Atualiza o sistema operacional
apt-get update -y
apt-get upgrade -y

# Instala os pacotes necessários para o Docker
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adiciona o repositório do Docker ao sistema
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list

# Atualiza a lista de pacotes novamente após adicionar o repositório
apt-get update -y

# Instala o Docker
apt-get install -y docker-ce docker-ce-cli containerd.io

# Ativa e inicia o serviço do Docker
systemctl enable docker
systemctl start docker

# Verifica se o Docker foi instalado corretamente
docker --version
