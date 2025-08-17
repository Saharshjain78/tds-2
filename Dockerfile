FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    MPLBACKEND=Agg \
    DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ python3-dev \
    libxml2 libxslt1.1 \
    libjpeg62-turbo zlib1g libpng16-16 libfreetype6 \
    libgl1 libglib2.0-0 \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY index.html .
COPY entrypoint.sh .

RUN chmod +x /app/entrypoint.sh

EXPOSE 8000
CMD ["./entrypoint.sh"]
