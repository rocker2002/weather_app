import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/location.dart';

class LocationService{

  static Future<List<Location>> fetchLocation(final query) async {
    try{
      final response = await http.get(Uri.parse('http://api.geonames.org/searchJSON?q=$query&maxRows=10&username=moizz_uddin_ahmad'));
      if(response.statusCode == 200)
       {  
        final data = jsonDecode(response.body);
        return (data['geonames'] as List).map((json) => Location.fromJson(json)).toList();}
      else{
        debugPrint(response.body);
        throw Exception("Failed to load weather data");
       }
    }catch(e){
      rethrow;
    }
}
}