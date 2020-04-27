import 'package:EasyWeather/screens/splashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.orangeAccent,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'GoogleSans',
        primaryColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.black),
      ),
      home: SplashScreen(),
    );
  }
}
