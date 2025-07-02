FROM python:3.13.4-alpine3.22


# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 4: Instalar dependências
# Copiamos primeiro o arquivo de requisitos para aproveitar o cache de camadas do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação
# O .dockerignore garantirá que arquivos desnecessários não sejam copiados.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 7: Definir o comando padrão para iniciar a aplicação
# O docker-compose.yml irá sobrescrever este comando para adicionar o --reload em desenvolvimento.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]