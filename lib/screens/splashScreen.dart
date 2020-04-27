import 'dart:async';

import 'package:EasyWeather/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _alignment = Alignment.bottomCenter;

  @override
  initState() {
    super.initState();
    Timer(Duration(milliseconds: 10), animate);
  }

  Future<Timer> loadTimer() async {
    return Timer(Duration(milliseconds: 500), navigate);
  }

  navigate() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  animate() {
    setState(() {
      _alignment = Alignment.center;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: FadeInImage(
              placeholder: AssetImage('assets/images/fade.jpg'),
              image: AssetImage('assets/images/splash_bg.jpg'),
              fadeInDuration: Duration(milliseconds: 300),
              fit: BoxFit.fitHeight,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            alignment: _alignment,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 5.0),
                Text(
                  'EasyWeather',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            onEnd: loadTimer,
          ),
        ],
      ),
    );
  }
}
