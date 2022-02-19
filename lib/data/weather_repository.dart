import 'package:flutter_weatherapp_blocc/data/weather_api_client.dart';

import '../locator.dart';
import '../models/weather.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<Weather> getWeather(String sehir) async {
    final int sehirID = await weatherApiClient.getLocationID(sehir);

    return await weatherApiClient.getWeather(sehirID);
  }
}
