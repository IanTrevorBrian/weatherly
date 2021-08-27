import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; //not a must to be used

const kTempTextStyle = TextStyle(
  fontFamily: 'raleway',
  color: Colors.green,
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'notoSerif',
  fontSize: 40.0,
    color: Colors.green,
);

// const kCityNameTextStyle = TextStyle(
//   fontFamily: 'Spartan MB',
//   fontSize: 60.0,
// );

const kNewCityNameTextStyle = TextStyle(
  fontFamily: 'playfairDisplay',
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
    color: Colors.green,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 90.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  // icon: Icon(
  //   Icons.location_city,
  //   color: Colors.green,
  // ),
  hintText: 'Enter City Name...',
  hintStyle: TextStyle(
    fontStyle: FontStyle.italic,
    // fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);


//I had to use this file to somewhat kinda explain how to pass data forward and backward

//HOW TO PASS DATA FORWARD

//I used this concept when I wanted to use the weatherData generated from one screen, to use in another screen
//To pass data forward to a state object, we can do that by passing it to a stateful widget,and then fetching it using the widget property in the state object

//HOW TO PASS DATA BACKWARD

//we use the Navigator.pop
//so basically, the Navigator.pop(context) has two values, one is always the context, which is ofcourse the current context, and we always pass that in order to pop the screen off, but there always the second OPTIONAL input which is [T result] and this is where we add the value that we want to pass back
