from flask import Flask, jsonify, request
import os
import requests
from prometheus_client import Counter, start_http_server

app = Flask(__name__)

REQUESTS = Counter('weather_requests_total', 'Total weather Requests')

@app.route('/weather', methods=['GET'])
def fetch_weather():
    REQUESTS.inc()

    latitude = request.args.get('lat')
    longitude = request.args.get('lon')
    api_key = os.environ.get('API_KEY')

    url = f'http://api.openweathermap.org/data/2.5/weather?lat={latitude}&lon={longitude}&appid={api_key}&units=metric'
    
    response = requests.get(url)
    data = response.json()
    
    if response.status_code == 200:
        city = data['name']
        weather_description = data['weather'][0]['description']
        temperature = data['main']['temp']
        wind_speed = data['wind']['speed']
        humidity = data['main']['humidity']

        return jsonify({
            "city": city,
            "weather": weather_description,
            "temperature": temperature,
            "wind_speed": wind_speed,
            "humidity": humidity
        })
    else:
        return jsonify({"error": "Failed to fetch weather data"}), 400

if __name__ == "__main__":
    start_http_server(8000)
    app.run(host='0.0.0.0', port=80)
