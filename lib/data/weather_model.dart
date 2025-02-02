class WeatherData {
  final double celcius;
  final double fahrenheit;
  final double wind_kph;
  final int humidity;
  WeatherData(
      {required this.celcius,
      required this.fahrenheit,
      required this.wind_kph,
      required this.humidity});

  factory WeatherData.fromJson(Map<String, dynamic> jsonData) {
    print(jsonData['temp_c']);
    print(jsonData['temp_f']);
    return WeatherData(
        celcius: jsonData['temp_c'],
        fahrenheit: jsonData['temp_f'],
        wind_kph: jsonData['wind_kph'],
        humidity: jsonData['humidity']);
  }
}
