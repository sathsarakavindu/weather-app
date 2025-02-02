import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/configs/app.dart';
import 'package:weather/features/search_page/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  String celcius;
  String wind;
  String humidity;
  String are;
  String status;
  SearchPage(
      {super.key,
      required this.celcius,
      required this.wind,
      required this.humidity,
      required this.are,
      required this.status});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc searchBloc = SearchBloc();
  TextEditingController searchController = TextEditingController();
  String? seatch_txt;
  @override
  void initState() {
    super.initState();
    searchBloc.add(
      InitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (previous, current) => current is SearchActionState,
      buildWhen: (previous, current) => current is! SearchActionState,
      bloc: searchBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SearchSuccessState:
            final success = state as SearchSuccessState;
            return SingleChildScrollView(
              child: Container(
                width: w,
                height: h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.1, 0),
                    tileMode: TileMode.clamp,
                    colors: [
                      Color.fromARGB(255, 233, 245, 255),
                      Color.fromARGB(255, 149, 202, 246),
                      Color.fromARGB(255, 161, 209, 248)
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: w * 0.70,
                        height: h * 0.06,
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            seatch_txt = searchController.text.trim();
                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                searchBloc.add(
                                  SearchInitialTextEvent(
                                      search_text: seatch_txt ?? ""),
                                );
                              },
                              icon: Icon(Icons.search),
                            ),
                            hintText: "Find Location",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        //margin: EdgeInsets.only(bottom: h * 0.0),
                        width: w * 0.50,
                        height: h * 0.038,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                            child: Text(
                          "Sun, 2 February",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${success.weatherData.celcius}°C",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 60),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(success.weatherData.weather_status == "Sunny"
                          ? AppConfig.sunnyGiff
                          : success.weatherData.weather_status ==
                                  "Partly cloudy"
                              ? AppConfig.partlyCloudyGiff
                              : success.weatherData.weather_status ==
                                      "Patchy rain nearby"
                                  ? AppConfig.rainyGiff
                                  : success.weatherData.weather_status ==
                                          "Clear"
                                      ? AppConfig.clearNightGiff
                                      : success.weatherData.weather_status ==
                                              "Overcast"
                                          ? AppConfig.overcastGiff
                                          : AppConfig.overcastGiff),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: w * 0.70,
                        height: h * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.black,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centers content vertically
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Centers content horizontally
                          children: [
                            Center(
                              child: Text(
                                "${success.weatherData.area}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            SizedBox(height: h * 0.005), // Adds spacing
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      AppConfig.windIcon,
                                      width: w * 0.10,
                                      height: h * 0.025,
                                    ),
                                    SizedBox(
                                        height: h * 0.0040), // Adds spacing
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Wind Speed",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "${success.weatherData.wind_kph} Kmph",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: w * 0.32,
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      AppConfig.humadityIcon,
                                      width: w * 0.10,
                                      height: h * 0.025,
                                    ),
                                    SizedBox(
                                        height: h * 0.0040), // Adds spacing
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      textAlign: TextAlign.right,
                                      "${success.weatherData.humidity}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          default:
            return SingleChildScrollView(
              child: Container(
                width: w,
                height: h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.1, 0),
                    tileMode: TileMode.clamp,
                    colors: [
                      Color.fromARGB(255, 233, 245, 255),
                      Color.fromARGB(255, 149, 202, 246),
                      Color.fromARGB(255, 161, 209, 248)
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: w * 0.70,
                        height: h * 0.06,
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            seatch_txt = searchController.text.trim();
                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                searchBloc.add(
                                  SearchInitialTextEvent(
                                      search_text: seatch_txt ?? ""),
                                );
                              },
                              icon: Icon(Icons.search),
                            ),
                            hintText: "Find Location",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        //margin: EdgeInsets.only(bottom: h * 0.0),
                        width: w * 0.50,
                        height: h * 0.038,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                            child: Text(
                          "Sun, 2 February",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${widget.celcius}°C",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 60),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(widget.status == "Sunny"
                          ? AppConfig.sunnyGiff
                          : widget.status == "Partly cloudy"
                              ? AppConfig.partlyCloudyGiff
                              : widget.status == "Patchy rain nearby"
                                  ? AppConfig.rainyGiff
                                  : widget.status == "Clear"
                                      ? AppConfig.clearNightGiff
                                      : widget.status == "Overcast"
                                          ? AppConfig.overcastGiff
                                          : AppConfig.overcastGiff),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: w * 0.70,
                        height: h * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.black,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centers content vertically
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Centers content horizontally
                          children: [
                            Center(
                              child: Text(
                                "Colombo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            SizedBox(height: h * 0.005), // Adds spacing
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      AppConfig.windIcon,
                                      width: w * 0.10,
                                      height: h * 0.025,
                                    ),
                                    SizedBox(
                                        height: h * 0.0040), // Adds spacing
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Wind Speed",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "${widget.wind} Kmph",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: w * 0.32,
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      AppConfig.humadityIcon,
                                      width: w * 0.10,
                                      height: h * 0.025,
                                    ),
                                    SizedBox(
                                        height: h * 0.0040), // Adds spacing
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      textAlign: TextAlign.right,
                                      "${widget.humidity}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
      listener: (context, state) {},
    );
  }
}


/*
Container(
      width: w,
      height: h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.1, 0),
          tileMode: TileMode.clamp,
          colors: [
            Color.fromARGB(255, 233, 245, 255),
            Color.fromARGB(255, 149, 202, 246),
            Color.fromARGB(255, 161, 209, 248)
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: w * 0.70,
              height: h * 0.06,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Find Location",
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //margin: EdgeInsets.only(bottom: h * 0.0),
              width: w * 0.50,
              height: h * 0.038,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                  child: Text(
                "Sun, 2 February",
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "${widget.celcius}°C",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: w * 0.70,
              height: h * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers content vertically
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Centers content horizontally
                children: [
                  Center(
                    child: Text(
                      "Colombo",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: h * 0.005), // Adds spacing
                  Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            AppConfig.windIcon,
                            width: w * 0.10,
                            height: h * 0.025,
                          ),
                          SizedBox(height: h * 0.0040), // Adds spacing
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Wind Speed",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "${widget.wind} Kmph",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w * 0.32,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            AppConfig.humadityIcon,
                            width: w * 0.10,
                            height: h * 0.025,
                          ),
                          SizedBox(height: h * 0.0040), // Adds spacing
                          Text(
                            "Humidity",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            textAlign: TextAlign.right,
                            "${widget.humidity}",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );*/