import 'package:weatherly/services/location.dart';
import 'package:weatherly/services/network.dart';

const apiKey = '02003aa993b1852010a46cb62a45699d';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  //a method in our WeatherModel that deals with getting the weather of a specific city
  Future <dynamic> getCityWeather(String cityName) async { //we have to pass in cityName as an input and use it to form our url

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric');
    //the above code is similar to the one in the getLocationWeather mtd
    //it is simplified to match the one in the getLocationWeather mtd for consistency
    //this is it below before its simplified
    // var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';
    //     NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //separate method in our WeatherModel that deals with getting the weather of a particular location
  Future <dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    //these two lines are also casualties of refactoring my code
    // latitude = location.latitude; //instead of printing into console i.e 'print(location.latitude);', we are going to save it into new var of type double
    // longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'); //initializing of a new network helper created from "NetworkHelper(this.url) constructor" and passing in the url created in network file //the url is the api urls thingy
    //method that initially returns nothing but gets the location //inside braces its going to do everything necessary to bring us current location //helps us get weather data

    var weatherData = await networkHelper.getData(); // to tap into that weather data that we get back from getData mtd in network file //this weatherData object helps send actual weather data from the networkHelper to any screen that needs it
    return weatherData; //to output our weatherData
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'super hot';
    } else if (temp > 20) {
      return 'nice weather'; //
    } else if (temp < 10) {
      return 'geez🥶, super cold'; //
    } else {
      return 'carry a jacket';
    }
  }
}