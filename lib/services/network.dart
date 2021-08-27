import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url); //initialized class and passed over a url that will be used to make a http request
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      return decodedData;//we return this decodedData as output of our mtd or we can just "return jsonDecode(data);"
    } else {
      print(response.statusCode);
    }
  }  //method that initially returns nothing but fetches data from weathermap


}


