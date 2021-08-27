import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/utilities/constants.dart';
import 'package:weatherly/services/weather.dart';
import 'city_screen.dart';
// import 'package:intl/intl.dart';




class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather; //pass data forward thro' routes by adding it as property to our widget //its in final because a little later we are gonna get weather from different source as well

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //we add late keyword to the below code because Non-nullable instance field 'temperature','condition' & 'cityName' must be initialized.
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String
      weatherIcon; //type changes from int to String and is now called weatherIcon from condition because the icon gotten from getWeather mtd is to be used inside our scaffold
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather); // instead of printing here we are passing over to this method and provide widget.locationWeather object as our input//basically when we tap into widget we get access to LocationScreen StatefulWidget which has a property of locationWeather(final) //this helps to display weather info received from loading_screen inside textwidget of the location_screen, which means getting the data from the LocationScreen object into LocationScreen state object(_LocationScreenState) //this is fundamental to understanding how flutter works
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      //the below if statement helps the app not crash when some conditions that are required by the app to run are not met...eg when location permission has been turned off
      //another thing to note is that return statement is used at the end of the if statement despite the statement being inside a void method
      //what will happen is that return will help by ending our mtd prematurely and prevent it from going to the next lines, which as we know will crash our app
      if (weatherData == null) {
        temperature = 0; //temp will be set to 0
        weatherIcon = ''; //there will be no icon
        cityName = ''; //there will be no city name
        weatherMessage = "sorry, can't get weather"; //this is the message that'll be displayed
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp
          .toInt(); //to remove decimals we have to input this line and the one above it

      var condition = weatherData['weather'][0][
          'id']; //condition changes to var that only exists inside our updateUI
      weatherIcon = weather.getWeatherIcon(condition); //uses WeatherModel
      weatherMessage = weather.getMessage(temperature); //uses WeatherModel

      cityName = weatherData['name'];
    }); //since our widgets depend on properties to figure what they need to display,so for our widgets to update,we have to wrap them inside our setState
  } //method that updates UI //we had to update from decodedData[] to weatherData[]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.fill),
          ),
          child: SafeArea(
              child: Column(
                children: <Widget>[
                  /* Search Row */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: () async {
                            var typedName = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return CityScreen();
                                }));
                            /* check for undefined */
                            if(typedName != null) {
                              var weatherData = await weather.getCityWeather(typedName);
                              updateUI(weatherData);
                            }
                          },
                          child: Icon(
                            Icons.search,
                            size: 35.0,
                            color: Colors.green,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      ),
                      Container(
                        /* Weather in current location */
                        child: GestureDetector(
                          onTap: () async {
                            var weatherData = await weather.getLocationWeather();
                            updateUI(weatherData);
                          },
                          child: Icon(
                            Icons.my_location,
                            size: 35.0,
                            color: Colors.green,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10.0, top: 10.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '$cityName',
                        textAlign: TextAlign.right,
                        style: kNewCityNameTextStyle,
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  /* Temperature + Emoji */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Text(
                      '$weatherMessage',
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              )),
        ));
  }
}




//
//       Scaffold(
//         body: Container(
// // decoration: BoxDecoration(
// //   image: DecorationImage(
// //     image: AssetImage('images/location_background.jpg'),
// //     fit: BoxFit.cover,
// //     colorFilter: ColorFilter.mode(
// //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
// //   ),
// // ),
//           constraints: BoxConstraints.expand(),
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     TextButton(
//                       onPressed: () async {
//                         var weatherData = await weather.getLocationWeather();
//                         updateUI(weatherData);
//                       },
//                       child: Icon(
//                         Icons.near_me,
//                         color: Colors.green,
//                         size: 35.0,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         var typedName = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return CityScreen();
//                             },
//                           ),
//                         );
//                         if(typedName != null) {
//                           var weatherData = await weather.getCityWeather(typedName);
//                           updateUI(weatherData);
//                         }
//                       },
//                       child: Icon(
//                         Icons.location_city,
//                         color: Colors.green,
//                         size: 35.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 15.0),
//                   child: Row(
//                     children: <Widget>[
//                       Text(
//                         '$temperature°',
//                         style: kTempTextStyle,
//                       ),
//                       Text(
//                         weatherIcon,
//                         style: kConditionTextStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 15.0),
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         '$cityName',
//                         textAlign: TextAlign.right,
//                         style: kCityNameTextStyle,
//                       ),
//                       Text(
//                         '$weatherMessage',
//                         textAlign: TextAlign.right,
//                         style: kMessageTextStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//   }
// }
//