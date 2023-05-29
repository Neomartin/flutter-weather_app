import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_weather_app/services/wheater.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  State<LoadingScreen> createState() => __LoadingScreen();
}

class __LoadingScreen extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      var data = await WeatherModel().getWeatherData();

      if (context.mounted) {
        Navigator.pushNamed(context, '/location', arguments: data);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(
          color: Colors.cyan,
          size: 100,
        ),
      ),
    );
  }
}
