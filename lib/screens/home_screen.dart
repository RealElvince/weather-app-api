import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // fetch data
  Future<WeatherModel> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=-1.2833&lon=36.8167&appid=e93fa4643f98fc45f56704e2b488a9af'));

    // checking response success
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return WeatherModel.fromJson(json);
    } else {
      throw Exception('Data Loading...');
    }
  }

  // Future variable and assign to fetchWeather in init state
  late Future<WeatherModel> myWeather;

  @override
  void initState() {
    super.initState();
    myWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
        child: Stack(
          children: [
            SafeArea(
              top: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      // Menu Icon
                      Icon(
                        IconlyBold.category,
                        color: Colors.white,
                      ),
                      // Avatar
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: AssetImage('images/avatar.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  FutureBuilder<WeatherModel>(
                    future: myWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.name,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            // Weather type
                            Text(
                              snapshot.data!.weather[0]['main'].toString(),
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 22.0,
                                  letterSpacing: 1.3,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            // Weather description
                            Text(
                              snapshot.data!.weather[0]['description']
                                  .toString(),
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 15.0,
                                  letterSpacing: 1.3,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),

                            // date
                            Text(
                              '12 March,2023',
                              style: GoogleFonts.abyssinicaSil(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            // cloud image
                            Container(
                              height: 250.0,
                              width: 250.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/cloudy.png'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Heat',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      '${((snapshot.data!.main['temp'] - 32 * 5 / 9).toStringAsFixed(2))}',
                                      style: GoogleFonts.abhayaLibre(
                                          color: Colors.white,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 50.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Wind',
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 15.0, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      '${snapshot.data!.wind["speed"]}km/h',
                                      style: GoogleFonts.abhayaLibre(
                                          color: Colors.white,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 50.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Humidity',
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      '${snapshot.data!.main['humidity']}%',
                                      style: GoogleFonts.abhayaLibre(
                                        color: Colors.white,
                                        fontSize: 21.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              color: Colors.black26,
                              height: MediaQuery.of(context).size.height / 10,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'See weekly weather forecast.',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Download data...');
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.black45,
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
