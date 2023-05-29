import 'dart:convert';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/services/location.dart';

const apiKey = '862c70e380cf5f9e19a3425c76609dbb';
const apiURL = 'api.openweathermap.org';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    List<geocoding.Location> locations =
        await geocoding.locationFromAddress(city);
    geocoding.Location location = locations.first;
    return await getWeatherData(
        lat: location.latitude, lon: location.longitude);
  }

  Future<dynamic> getWeatherData({double? lat, double? lon}) async {
    if (lat == null || lon == null) {
      Location location = Location();
      Position position = await location.getCurrentLocation();
      lat = position.latitude;
      lon = position.longitude;
    }

    var queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': 'metric'
    };

    var url = Uri.https(apiURL, '/data/2.5/weather', queryParams);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
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
