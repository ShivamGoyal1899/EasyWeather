import 'dart:async';
import 'dart:convert';

import 'package:EasyWeather/model/weatherModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
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
