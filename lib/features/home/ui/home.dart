import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/features/home/bloc/home_bloc.dart';
import 'package:weather/features/search_page/ui/search_page.dart';
import 'package:weather/repositories/fetch_weather.dart';
import 'package:weather/repositories/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(
      WeatherInitialEvent(),
    );
    //fetchData();
  }

  void fetchData() async {
    Position position = await LocationConfig().determinePosition();
    print(position.latitude);
    print(position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is WeatherAction,
        buildWhen: (previous, current) => current is! WeatherAction,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WeatherLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case WeatherSuccessState:
              final success = state as WeatherSuccessState;
              return SearchPage(
                celcius: success.weatherData.celcius.toString(),
                wind: success.weatherData.wind_kph.toString(),
                humidity: success.weatherData.humidity.toString(),
                are: success.weatherData.area,
                status: success.weatherData.weather_status,
              );
            default:
              return SizedBox();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
