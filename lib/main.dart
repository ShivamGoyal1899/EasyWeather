import 'package:flutter/material.dart';
import 'package:OpenWeatherApp/model/weather_model.dart';
import 'package:OpenWeatherApp/services/api_services.dart';
import 'package:flutter/services.dart';

import 'appBar/appbar.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  ApiResponse api = ApiResponse();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.orangeAccent,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Raleway',
        primaryColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.black),
      ),
      home: Scaffold(
        appBar: CustomAppBar(),
        body: FutureBuilder<Weather>(
          future: api.getWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              child: Text(
                            'Yesterday',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          )),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: null,
                            disabledColor: Colors.orange,
                            disabledElevation: 4.0,
                            disabledTextColor: Colors.black,
                            child: Container(
                              alignment: Alignment.center,
                              width: 80.0,
                              child: Text(
                                "Today",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0),
                              ),
                            ),
                            color: Colors.orange,
                          ),
                          Container(
                              child: Text(
                            'Tomorrow',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          )),
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/header.jpg'),
                                  alignment: Alignment.centerRight)),
                          height: 240.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(snapshot.data.name,
                                    style: TextStyle(
                                        fontSize: 45.0,
                                        fontWeight: FontWeight.w700)),
                                Text(
                                    (snapshot.data.main.temp - 273.15)
                                            .toInt()
                                            .toString() +
                                        '°',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.w700)),
                                Container(
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.network(
                                        'http://openweathermap.org/img/wn/' +
                                            snapshot.data.weather[0].icon +
                                            '.png',
                                        width: 25,
                                      ),
                                      Text(
                                          '  ' +
                                              snapshot.data.weather[0]
                                                  .description[0]
                                                  .toUpperCase() +
                                              snapshot
                                                  .data.weather[0].description
                                                  .substring(1),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 10.0,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        height: 260.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/drop.png',
                                                width: 20,
                                              ),
                                              Text(
                                                "  Humidity",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.0),
                                          Text(
                                            snapshot.data.main.humidity
                                                    .toString() +
                                                "%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/sunny.png',
                                                width: 20,
                                              ),
                                              Text(
                                                "  Visibility",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.0),
                                          Text(
                                            snapshot.data.visibility.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.purpleAccent),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/wind.png',
                                                width: 20,
                                              ),
                                              Text(
                                                "  Wind",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.0),
                                          Text(
                                            snapshot.data.wind.speed
                                                    .toString() +
                                                " km/h",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Container(
                                              height: 5.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.pinkAccent),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/brakes.png',
                                                width: 20,
                                              ),
                                              Text(
                                                "  Pressure",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.0),
                                          Text(
                                            snapshot.data.main.pressure
                                                    .toString() +
                                                " hpa",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
                alignment: Alignment.center,
                child:
                    CircularProgressIndicator(backgroundColor: Colors.black));
          },
        ),
      ),
    );
  }
}
