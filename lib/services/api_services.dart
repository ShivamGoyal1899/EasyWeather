import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class ApiResponse {
  Future<Weather> getWeather() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=Delhi&APPID=6adf87802066a3ee22591eb3f8abfe0c';
    final response = await http.get(url);
    return Weather.fromJson(json.decode(response.body));
  }
}
