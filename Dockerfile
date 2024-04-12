FROM python:3.11-alpine

WORKDIR /app

COPY . .

RUN apk update && apk upgrade

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "weather_api_call.py"]
