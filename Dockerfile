# Use uma imagem base estável e leve do Python. A versão 3.10-slim é uma boa escolha.
FROM python:3.10-slim

# Define o diretório de trabalho no container
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
# Isso acelera as builds futuras se as dependências não mudarem.
COPY requirements.txt ./

# Instala as dependências
# --no-cache-dir reduz o tamanho da imagem final
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que o uvicorn vai rodar
EXPOSE 8000

# Comando para iniciar a aplicação quando o container for executado
# Usamos --host 0.0.0.0 para que a aplicação seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]