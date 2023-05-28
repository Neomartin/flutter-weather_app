import 'package:flutter/material.dart';
import 'package:simple_weather_app/services/wheater.dart';
import 'package:simple_weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  dynamic data;
  String cityName = '';
  double temperature = 0;
  int weatherIcon = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    cityName = data['name'];
    temperature = data['main']['temp'];
    weatherIcon = data['weather'][0]['id'];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('images/location.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.65),
            BlendMode.dstATop,
          ),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    temperature.toStringAsFixed(0),
                    style: kTempText,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '°',
                        style: TextStyle(fontSize: 70.0),
                      ),
                      Text(
                        weather.getWeatherIcon(weatherIcon),
                        style: const TextStyle(
                          fontSize: 70.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weather.getMessage(temperature.toInt()),
                      style: kMessageTextStyle,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      cityName,
                      textAlign: TextAlign.right,
                      style: kButtonTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
