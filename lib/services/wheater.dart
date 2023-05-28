import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '862c70e380cf5f9e19a3425c76609dbb';
const apiURL = 'api.openweathermap.org';

class WeatherModel {
  Future getWeatherData({required double lat, required double lon}) async {
    var queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': 'metric'
    };

    var url = Uri.https(apiURL, '/data/2.5/weather', queryParams);
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300)
      return '🌩';
    else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
