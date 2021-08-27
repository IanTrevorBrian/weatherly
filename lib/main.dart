import 'package:flutter/material.dart';
import 'package:weatherly/screens/loading_screen.dart';

void main() {
  runApp(WeatherFox());
}

class WeatherFox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
        home: LoadingScreen(),
    );
  }
}


