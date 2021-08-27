import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherly/services/weather.dart';
import 'location_screen.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //had to remove these two lines as a way of rafactoring code and replaced our code in the apr url by adding ${location.latitude} and ${location.longitude}//but its not amust and we can leave it as it is

  // late double latitude;
  // late double longitude;

  @override
  void initState() {
    super.initState();   //init state only calls once and thats when State<LoadingScreen> gets initialized and gets created

    getLocationData(); //combined callback for both getData() and getLocation()
    getPermission();
  }

  //the below method was made as a result of combining two methods; 'getLocation(); and 'getData()'
  void getLocationData() async {

    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

   Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,);  //when we init Location screen we have a property of locationWeather and we pass over weatherData to set it as a new var
    }));

  }

  void getPermission() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      print(permission);
    } catch (e) {
      print (e);
    }
  } //method that initially returns nothing but gets the permission //like other methods in this State<LoadingScreen> it only gets called once and that is to either turn the location on or not


  @override
  Widget build(BuildContext context) { //build gets called any time our widgets change,be it that text change, color change etc
    return Scaffold(
      body: Center(
        child: SpinKitRipple(
          color: Colors.green[900]!,
          size: 300.0,
        ),
      ),
    );
  }
}

// Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

// child: ElevatedButton(
// onPressed: () {
// getLocation();
// },//when user presses this button,it calls the getLocation() method
// child: Text('Get location'),
// ),


//HOW CODE WORKS

//Basically as per getting actual weather data from openweather api episode, this is how our code works;

//1. it uses the geolocator package to get lat and lon "latitude = location.latitude;", "longitude = location.longitude;"
//2. we put them into our url  " NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'); "
//3.we use our network helper.getData() to get data by networking with the opeanweathermap url provided in "await http.get(Uri.parse(url));" inside network file
//4.we then check status code and return data that we get back passing it using jsonDecode