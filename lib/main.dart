import 'package:easy_weather/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        primaryIconTheme: const IconThemeData(color: Colors.black),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orangeAccent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
