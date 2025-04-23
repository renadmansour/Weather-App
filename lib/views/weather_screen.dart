import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/helper/model.dart';
import 'package:weather_app/helper/showFlushBar.dart';
import 'package:weather_app/views/error_screen.dart';
import 'package:weather_app/views/loading_screen.dart';
import '../helper/enum.dart';
import '../helper/location.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ApiState apiState = ApiState.none;
  WeatherData? weatherData;

  void getData() async {
    setState(() {
      apiState = ApiState.loading;
    });
    try {
      Position position = await determinePosition();
      final response = await Dio().get(
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid={replace-with-your-api-key}");
      setState(() {
        apiState = ApiState.success;
        weatherData = WeatherData.fromMap(response.data);
      });
    } catch (e) {
      setState(() {
        apiState = ApiState.error;
      });
      showError(e.toString(), context);
    }
  }

  String getWeatherImageById(int id) {
    if (id <= 232) {
      return 'assets/thunder.png';
    } else if (id <= 321) {
      return 'assets/drizzle.png';
    } else if (id <= 531) {
      return 'assets/rain.png';
    } else if (id <= 622) {
      return 'assets/snow.png';
    } else if (id <= 781) {
      return 'assets/tornado.png';
    } else if (id == 800) {
      return 'assets/clear.png';
    } else {
      return 'assets/cloudy.png';
    }
  }

  String getMessageByTemp(double temp) {
    if (temp < 25) {
      return "It's 🍦 time";
    } else if (temp > 20) {
      return "Time for 🩳 and 👕";
    } else if (temp < 10) {
      return "You'll need 🧣 and 🧤";
    } else {
      return "Bring a 🧥 just in case";
    }
  }
  // StatefulWidget lifecycle
  // Constructor - CreateState - initState - build

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return apiState == ApiState.loading
        ? LoadingScreen()
        : apiState == ApiState.error
            ? ErrorScreen()
            : Scaffold(
                backgroundColor: Color(0xff3A3F54),
                appBar: AppBar(
                  backgroundColor: Color(0xff3A3F54),
                  title: Text("Weather App",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  centerTitle: true,
                ),
                body: Center(
                  child: Column(
                    spacing: 20,
                    children: [
                      Text(weatherData!.name!,
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              "${(weatherData!.main!.temp! - 272.15).toStringAsFixed(1)} °",
                              style:
                                  TextStyle(fontSize: 60, color: Colors.white)),
                          Image(
                            image: AssetImage(getWeatherImageById(
                                weatherData!.weather![0].id!)),
                            height: 150,
                            width: 150,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        "${weatherData!.weather![0].main!} in ${weatherData!.sys!.country!}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Lat:${weatherData!.coord!.lat!.toString()} - Lon:${weatherData!.coord!.lon!.toString()}",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Wind Speed\n${weatherData!.wind!.speed!.toString()}",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Visibility\n${weatherData!.visibility!}",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Humidity\n${weatherData!.main!.humidity!}",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        getMessageByTemp(
                          weatherData!.main!.temp!,
                        ),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
