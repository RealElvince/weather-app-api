import 'package:flutter/material.dart';
import 'package:weatherapp/screens/onboarding_screen.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Colors.black87,
        scaffoldBackgroundColor: Colors.teal,
      ),
      home: const OnBoardingScreen(),
    );
  }
}
