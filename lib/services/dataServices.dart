import 'dart:async';
import 'dart:convert';

import 'package:EasyWeather/model/weatherModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiResponse {

  Future<Weather> getWeatherByName(String city) async{
    var defaultKey = "8a5d5a4287b457081c1a32e12d5e236b";

    var url1 =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$defaultKey";
    final response = await http.get(url1);
    return Weather.fromJson(json.decode(response.body));
  }



  Future<Weather> getWeather() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    String url = 'http://api.openweathermap.org/data/2.5/weather?lat=' +
        position.latitude.toString() +
        '&lon=' +
        position.longitude.toString() +
        '&APPID=6adf87802066a3ee22591eb3f8abfe0c';
    final response = await http.get(url);
    return Weather.fromJson(json.decode(response.body));
  }
}
