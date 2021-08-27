import 'package:flutter/material.dart';
import 'package:weatherly/utilities/constants.dart';
import 'package:weatherly/elavated_button.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weatherly'),
        textTheme: TextTheme(
          headline6: TextStyle( // headline6 is used for setting title's theme
            color: Colors.green,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/city_background.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: Icon(
              //       Icons.arrow_back_ios,
              //       color: Colors.green,
              //       size: 35.0,
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,   //input text color
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              SimpleElevatedButton(
                buttonTitle: 'Get Weather',
                onTap: () {
                  Navigator.pop(context, cityName);  //cityName is the value to be passed backward and is accessed in Navigator.push, in our location screen, as a future value
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}






//the textbutton that i replaced with SimpleElevated button
// TextButton(
// onPressed: () {
// Navigator.pop(context, cityName);  //cityName is the value to be passed backward and is accessed in Navigator.push, in our location screen, as a future value
// },
// child: Text(
// 'Get Weather',
// style: kButtonTextStyle,
// ),
// ),