FROM python:3.10-slim

WORKDIR /

COPY . .
ENV PYTHONUNBUFFERED=1
RUN pip install flask
CMD ["python3", "app.py"]
