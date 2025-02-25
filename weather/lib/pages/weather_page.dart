import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather/models/weather_models.dart";
import "package:weather/services/weather_services.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // API KEY
  final _weatherService = WeatherService('6bafe64da4cd5fa99fada6ad0b0c69fb');
  Weather? _weather;

  //FETCH WEATHER
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //ANY ERROR
    catch (e) {
      print(e);
    }

  }

  //WEATHER ANIMATION
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/sunny.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain': 
        return 'assets/rain.json';
      case 'thunderstrom':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';

    }
  }

    

  //INIT STATE
  @override
  void initState() {
    super.initState();

    //FETCH WEATHER ON STARTUP
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //CITY NAME
          Text(_weather?.cityName ?? "loading city.."),

          //ANIMATION
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          //TEMPERATURE
          Text('${_weather?.temperature.round()}*C'),

          //WEATHER CONDITION
          Text(_weather?.mainCondition ?? '')

          ],
        ),
      ),
    );
  }
}

