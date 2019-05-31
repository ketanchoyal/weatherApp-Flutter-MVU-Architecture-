import 'package:http/http.dart' as http;
import 'dart:convert';

const String url =
    "https://api.darksky.net/forecast/4e1787d857dec2e733a3c5b8b4fa9efc/37.8267,-122.4233";

Future<double> _getWeather(String url) async {

  http.Response response = await http.get(url);
  

  return _parseJson(response);
}

double _parseJson(http.Response response) {

  var decode = jsonDecode(response.body);

  return decode["currently"]["temperature"];
}

Future<double> getForecastData() => _getWeather(url);

