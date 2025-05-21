import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget{
  const WeatherApp({super.key});
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp>{
  WeatherService weather = WeatherService();
  static final String? api_key = dotenv.env['API_KEY'];
  late final lahoreWeather;
  @override
  void initState(){
    super.initState();
    lahoreWeather = weather.fetchWeather('Lahore', api_key);
  }


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: _weatherReport(),
                ),
                Expanded(
                  child: _weatherWeek()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _weatherReport(){
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/rainy.jpg', fit: BoxFit.cover, cacheHeight: 970, cacheWidth: 1000,),
          
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _weatherType(),
              _weatherCity(),
              _weatherTemp()
            ],
          )
        )
      ]
    );
  }

  Widget _weatherType(){
    return FutureBuilder<Weather>(
      future: lahoreWeather, builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('${snapshot.data?.getWeather}', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight:  FontWeight.bold)),
            );
        }
      }
      );
  }

   Widget _weatherCity(){
    return FutureBuilder<Weather>(
      future: lahoreWeather, builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('${snapshot.data?.getCity}', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight:  FontWeight.bold)),
            );
        }
      }
      );
      
  }
   Widget _weatherTemp(){
    return FutureBuilder<Weather>(
      future: lahoreWeather, builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('${snapshot.data?.getTemp.round()}°', style: TextStyle(color: Colors.white, fontSize: 90, fontWeight:  FontWeight.bold)),
            );
        }
      }
      );
        
  }

  Widget _weatherRow(String day, String emoji, String temp){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(day, style: TextStyle(fontSize: 25),),
        Text(emoji, style: TextStyle(fontSize: 25),),
        Text(temp, style: TextStyle(fontSize: 25),)
      ],
      ),
    );
  }

  Widget _weatherWeek(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _weatherRow("Monday", '🌩️', "2° -1°"),
        _weatherRow("Tuesday", '🌩️', "8° 4°"),
        _weatherRow("Wednesday", '🌩️', "11° 6°"),
      ],
    );
  }
  
}

class Weather{
  late String weather;
  late double mainTemp;
  late String city;

  Weather({required this.weather, required this.mainTemp, required this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weather: json['weather'][0]['main'],
    mainTemp: json['main']['temp'],
    city: json['name']
    );
  }

  String get getWeather{
    return weather;
  }

  double get getTemp{
    return mainTemp;
  }

  String get getCity{
    return city;
  }

  Map<String, dynamic> toJson() => {'weather': weather, 'mainTemp': mainTemp, 'city': city};
}

class WeatherService{
  static const base_url = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> fetchWeather(String cityName, String? api_key) async {
    try{
      final data = await http.get(Uri.parse('$base_url/weather?q=$cityName&appid=$api_key&units=metric'));
      if(data.statusCode == 200)
       {  
        return Weather.fromJson(jsonDecode(data.body) as Map<String, dynamic>);
       }else{
        throw Exception("Failed to load weather data");
       }
    }catch(e){
      throw Exception("Failed: $e");
    }
  }

}






  


