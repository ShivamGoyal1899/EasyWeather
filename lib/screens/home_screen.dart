import 'package:easy_weather/model/weather_model.dart';
import 'package:easy_weather/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiResponse dataState = ApiResponse();

  _launchURL() async {
    String url = 'https://github.com/ShivamGoyal1899/EasyWeather';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
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
          icon: const Icon(
            Icons.info_outline,
            color: Colors.black,
          ),
          onPressed: _launchURL,
        ),
        title: Text(
          'EasyWeather',
          style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 28.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
          return snapshot.hasData
              ? Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              DateFormat("EEEE, d MMMM").format(
                                DateTime.now(),
                              ),
                              style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 4.0,
                              onPressed: null,
                              disabledColor: Colors.orange,
                              disabledElevation: 4.0,
                              disabledTextColor: Colors.black,
                              color: Colors.orange,
                              child: Container(
                                alignment: Alignment.center,
                                width: 80.0,
                                child: Text(
                                  "Today",
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
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
                                  snapshot.data!.name,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Day ${(snapshot.data!.main.tempMax - 273.15).toInt()}° ↑ • Night ${(snapshot.data!.main.tempMin - 273.15).toInt()}° ↓',
                                  style: GoogleFonts.nunitoSans(
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
                                      '${(snapshot.data!.main.temp - 273.15).toInt()}°',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 100.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.network(
                                          'http://openweathermap.org/img/wn/${snapshot.data!.weather[0].icon}.png',
                                          height: 40,
                                        ),
                                        snapshot.data!.weather[0].description
                                                .contains(' ')
                                            ? Text(
                                                '${snapshot.data!.weather[0].description.split(' ')[0][0].toUpperCase()}${snapshot.data!.weather[0].description.split(' ')[0].substring(1)}\n${snapshot.data!.weather[0].description.split(' ')[1][0].toUpperCase()}${snapshot.data!.weather[0].description.split(' ')[1].substring(1)}',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              )
                                            : Text(
                                                snapshot.data!.weather[0]
                                                        .description[0]
                                                        .toUpperCase() +
                                                    snapshot.data!.weather[0]
                                                        .description
                                                        .substring(1),
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                        const SizedBox(height: 5.0)
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  'Feels like ${(snapshot.data!.main.feelsLike - 273.15).toInt()}°',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Details',
                            style: GoogleFonts.nunitoSans(
                                fontSize: 26.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
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
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    color: Colors.white,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
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
                                          const SizedBox(height: 20.0),
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
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            "${snapshot.data!.main.humidity}%",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    color: Colors.white,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
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
                                          const SizedBox(height: 20.0),
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
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            snapshot.data!.visibility
                                                        .toString() ==
                                                    'null'
                                                ? 'N/A'
                                                : '${snapshot.data!.visibility} m',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    color: Colors.white,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
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
                                          const SizedBox(height: 20.0),
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
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            "${snapshot.data!.wind.speed.toStringAsFixed(1)} km/h",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 2.0,
                                    onPressed: null,
                                    disabledColor: Colors.white,
                                    disabledElevation: 2.0,
                                    disabledTextColor: Colors.black,
                                    color: Colors.white,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 140.0,
                                      height: 120.0,
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
                                          const SizedBox(height: 20.0),
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
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            "${snapshot.data!.main.pressure} hPa",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.black),
                );
        },
      ),
    );
  }
}
