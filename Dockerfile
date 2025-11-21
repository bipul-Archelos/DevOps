FROM python:3.10-slim

WORKDIR /

COPY . .
ENV PYTHONUNBUFFERED=1
CMD ["python3", "app.py"]
