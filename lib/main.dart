import 'package:flutter/material.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget{
  const WeatherApp({super.key});

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
            children: [
              _weatherType(),
              _weatherCity(),
              _weatherTemp()]
          )
        )
      ]
    );
  }

  Widget _weatherType(){
    return Text("Thunderstorm", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),);

  }

   Widget _weatherCity(){
    return Text("Lahore", style: TextStyle(fontSize: 25, color: Colors.white),);
      
  }
   Widget _weatherTemp(){
    return Text("8°", style: TextStyle(fontSize: 150, color: Colors.white),);
        
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


  


