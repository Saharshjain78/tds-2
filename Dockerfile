# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Make Python behave nicely in containers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies (only if you need to compile deps)
RUN apt-get update && apt-get install -y \
    gcc g++ python3-dev \
 && rm -rf /var/lib/apt/lists/*

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY app.py .
COPY index.html .
COPY entrypoint.sh .
COPY .env* ./  # optional, will copy if present

# Ensure entrypoint is executable
RUN chmod +x /app/entrypoint.sh

# Expose the port the app runs on (Railway sets $PORT at runtime)
EXPOSE 8000

# Start the app (Railway will set $PORT; your script defaults to 8000 locally)
CMD ["./entrypoint.sh"]
