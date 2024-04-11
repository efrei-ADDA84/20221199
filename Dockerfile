FROM python:3.11-alpine

WORKDIR /app

COPY weather_api_call.py .

RUN apk update && apk upgrade

RUN pip install --no-cache-dir requests==2.31.0

CMD ["python", "weather_api_call.py"]
