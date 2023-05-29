import 'package:flutter/material.dart';
import 'package:simple_weather_app/services/location.dart';
import 'package:simple_weather_app/services/wheater.dart';
import 'package:simple_weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final BuildContext context;
  const LocationScreen({required this.context, Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  double lat = 0;
  double lon = 0;
  String cityName = '';
  double temperature = 0;
  int weatherIcon = 0;
  @override
  void initState() {
    super.initState();
    dynamic data = ModalRoute.of(widget.context)!.settings.arguments as Map;
    updateUI(data);
  }

  Location location = Location();
  void updateUI(data) async {
    print(data);

    if (data == null) {
      temperature = 0;
      weatherIcon = -1;
      cityName = 'Error';
      lat = 0;
      lon = 0;
    }
    setState(() {
      temperature = data['main']['temp'];
      weatherIcon = data['weather'][0]['id'];
      cityName = data['name'];
      lat = data['coord']['lat'];
      lon = data['coord']['lon'];
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () async {
                        var data = await weather.getWeatherData();
                        updateUI(data);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.white,
                      )),
                  TextButton(
                      onPressed: () async {
                        var typedName =
                            await Navigator.pushNamed(context, '/city');
                        if (typedName != null) {
                          var data = await weather
                              .getCityWeather(typedName.toString());
                          updateUI(data);
                        }
                      },
                      child: const Icon(
                        Icons.search,
                        size: 50.0,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
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
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      color: Colors.black.withOpacity(0.50),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${lat.toString()} ${lon.toString()}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),
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
