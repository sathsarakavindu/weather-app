import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/configs/app.dart';
import 'package:weather/data/weather_model.dart';

class FetchWeather {
   Future <WeatherData> fetchWeatherData(String area) async {
    final client = await http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=3fa13275184949e2a3d102025232402&q=${area}&aqi=no'));
    final response = await jsonDecode(client.body);
    return WeatherData.fromJson(response) as WeatherData;
  }
}
