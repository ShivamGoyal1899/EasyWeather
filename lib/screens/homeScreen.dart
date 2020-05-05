import 'package:EasyWeather/model/weatherModel.dart';
import 'package:EasyWeather/services/dataServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiResponse dataState = ApiResponse();

  _launchURL() async {
    const url = 'https://github.com/ShivamGoyal1899/EasyWeather';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.info_outline,
            color: Colors.black,
          ),
          onPressed: _launchURL,
        ),
        title: Text(
          'EasyWeather',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 28.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {
              Share.share(
                  'Download EasyWeather App Now. https://github.com/ShivamGoyal1899/EasyWeather',
                  subject: 'EasyWeather App');
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: FutureBuilder<Weather>(
        future: dataState.getWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Text(
                                DateFormat("EEEE, d MMMM")
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/header.png'),
                                  alignment: Alignment.centerRight),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.name,
                                    style: TextStyle(
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Day ' +
                                        (snapshot.data.main.tempMax - 273.15)
                                            .toInt()
                                            .toString() +
                                        '° ↑' +
                                        ' • ' +
                                        'Night ' +
                                        (snapshot.data.main.tempMin - 273.15)
                                            .toInt()
                                            .toString() +
                                        '° ↓',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        (snapshot.data.main.temp - 273.15)
                                                .toInt()
                                                .toString() +
                                            '°',
                                        style: TextStyle(
                                          fontSize: 100.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Image.network(
                                              'http://openweathermap.org/img/wn/' +
                                                  snapshot
                                                      .data.weather[0].icon +
                                                  '.png',
                                              height: 40,
                                            ),
                                            snapshot.data.weather[0].description
                                                    .contains(' ')
                                                ? Text(
                                                    snapshot.data.weather[0]
                                                            .description
                                                            .split(' ')[0][0]
                                                            .toUpperCase() +
                                                        snapshot.data.weather[0]
                                                            .description
                                                            .split(' ')[0]
                                                            .substring(1) +
                                                        '\n' +
                                                        snapshot.data.weather[0]
                                                            .description
                                                            .split(' ')[1][0]
                                                            .toUpperCase() +
                                                        snapshot.data.weather[0]
                                                            .description
                                                            .split(' ')[1]
                                                            .substring(1),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  )
                                                : Text(
                                                    snapshot.data.weather[0]
                                                            .description[0]
                                                            .toUpperCase() +
                                                        snapshot.data.weather[0]
                                                            .description
                                                            .substring(1),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                            SizedBox(height: 5.0)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Feels like ' +
                                        (snapshot.data.main.feelsLike - 273.15)
                                            .toInt()
                                            .toString() +
                                        '°',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
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
                                        height: 120.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                        height: 120.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6.0),
                                            Text(
                                              snapshot.data.visibility
                                                          .toString() ==
                                                      'null'
                                                  ? 'N/A'
                                                  : snapshot.data.visibility
                                                          .toString() +
                                                      ' m',
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
                                SizedBox(height: 10.0),
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
                                        height: 120.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6.0),
                                            Text(
                                              snapshot.data.wind.speed
                                                      .toStringAsFixed(1) +
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
                                        height: 120.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6.0),
                                            Text(
                                              snapshot.data.main.pressure
                                                      .toString() +
                                                  " hPa",
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
                )
              : Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.black));
        },
      ),
    );
  }
}
