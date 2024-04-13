import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("f1ca7a1d5577dc7af7912fce300b485f");

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String  getWeatherAnimation(String? mainCondition){
    if (mainCondition == null) {
      return "assets/weather/sunny.json";
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/weather/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/weather/rainy.json';
      case 'thunderstorm':
        return 'assets/weather/thunder.json';
      case 'clear':
        return 'assets/weather/sunny.json';
      default:
        return 'assets/weather/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Get Current City Name
            Text(_weather?.cityName??"Loading City ..."),
            //Lottie Annimations
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? "sunny")),
            // Fetch current temperature
            Text('${_weather?.temperature.round()} C'),

            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
