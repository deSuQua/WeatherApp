import 'package:http/http.dart' as http;
import "package:flutter_application_2/Widgets/model/weather_model.dart";

class WeatherApi {
  Future<Weather> getWeather(String city) async {
    final response = await http.Client().get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=7846927a1505d41db432b2b9fb02a873"));

    if (response.statusCode != 200) throw Exception();
    final Weather weather = weatherFromJson(response.body);
    print(response.body);
    return weather;
  }
}
