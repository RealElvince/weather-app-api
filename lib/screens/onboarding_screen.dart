import 'package:flutter/material.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10)).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Weather Forecast App!',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 250.0,
                  width: 250.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'images/weather.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
