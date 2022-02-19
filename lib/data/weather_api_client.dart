import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com/';
  final http.Client httpClient = http.Client();

  Future<int> getLocationID(String sehirAdi) async {
    final sehirUrl = baseUrl + '/api/location/search/?query=' + sehirAdi;
    final gelenCevap = await httpClient.get(Uri.parse(sehirUrl));
    

    if (gelenCevap.statusCode != 200) {
      throw Exception('Veri Getirilemedi...');
    }
    
    int data = gelenCevap.body.indexOf('woeid');
    
    String data2 = gelenCevap.body.substring(data);
    
    int index = data2.indexOf(':');
    int index2 = data2.indexOf(',');
    String data3 = data2.substring(index + 1, index2);
    

    
    return int.parse(data3);
  }

  Future<Weather> getWeather(int sehirID) async {
    
    final havaDurumuUrl = baseUrl + 'api/location/$sehirID';
    
    final havaDurumuGelenCevap = await httpClient.get(Uri.parse(havaDurumuUrl));
    

    if (havaDurumuGelenCevap.statusCode != 200) {
      
      throw Exception('Hava Durumu Getirilemedi...');
    }
    

    var havaDurumuCevapJSON =
        (json.decode(havaDurumuGelenCevap.body)) as Map<String, dynamic>;
    
    return Weather.fromJson(havaDurumuCevapJSON);
  }
}
