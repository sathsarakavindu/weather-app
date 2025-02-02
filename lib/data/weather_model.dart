class WeatherData {
  final double celcius;
  final double fahrenheit;
  final double wind_kph;
  final int humidity;
  final String area;
  final String weather_status;
  WeatherData(
      {required this.celcius,
      required this.fahrenheit,
      required this.wind_kph,
      required this.humidity,
      required this.area,
      required this.weather_status});

  factory WeatherData.fromJson(Map<String, dynamic> jsonData) {
    return WeatherData(
        celcius: jsonData['current']['temp_c'],
        fahrenheit: jsonData['current']['temp_f'],
        wind_kph: jsonData['current']['wind_kph'],
        humidity: jsonData['current']['humidity'],
        area: jsonData['location']['name'],
        weather_status: jsonData['current']['condition']['text']);
  }
}
