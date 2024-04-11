import os
import requests

def fetch_weather(latitude, longitude):
    url = f'http://api.openweathermap.org/data/2.5/weather?lat={latitude}&lon={longitude}&appid={api_key}&units=metric'
    
    response = requests.get(url)
    data = response.json()
    
    if response.status_code == 200:
        weather_description = data['weather'][0]['description']
        temperature = data['main']['temp']
        wind_speed = data['wind']['speed']
        humidity = data['main']['humidity']
        
        return f"The weather is {weather_description} with a temperature of {temperature}°C. Wind speed is {wind_speed} m/s and humidity is {humidity}%."
    else:
        return "Failed to fetch weather data"

if __name__ == "__main__":
    api_key = os.environ.get('API_KEY')
    latitude = os.environ.get('LAT')
    longitude = os.environ.get('LONG')
    print(fetch_weather(latitude, longitude))