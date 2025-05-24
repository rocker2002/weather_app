import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService{
  static const base_url = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> fetchWeather(double lat, double lon, String? apiKey) async {
    try{
      final data = await http.get(Uri.parse('$base_url/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
      if(data.statusCode == 200)
       {  
        return Weather.fromJson(jsonDecode(data.body) as Map<String, dynamic>);
       }else{
        debugPrint(data.body);
        throw Exception("Failed to load weather data");
       }
    }catch(e){
      rethrow;
    }
}
}