import 'package:flutter/material.dart';
import 'package:simple_weather_app/utilities/constants.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? cityName;
    return Scaffold(
      appBar: AppBar(
          title: const Text('City Screen'),
          backgroundColor: Colors.blueGrey[900],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, cityName);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.location_city),
                    iconColor: Colors.white,
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.orange.shade300, fontSize: 18),
                  onChanged: (value) {
                    cityName = value;
                  },
                  onEditingComplete: () {
                    Navigator.pop(context, cityName);
                  },
                  textInputAction: TextInputAction.go,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'City search',
                  textAlign: TextAlign.center,
                  style: kNormalMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
