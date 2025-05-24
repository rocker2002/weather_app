import 'package:flutter/material.dart';
import '../models/weather.dart';
class WeatherReport extends StatelessWidget{

  final Future<Weather>? currentWeather;

   const WeatherReport({
    super.key,
    required this.currentWeather,
    
  });
  @override
  Widget build(BuildContext context){
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
      future: currentWeather, builder: (context, snapshot){
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
      future: currentWeather, builder: (context, snapshot){
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
      future: currentWeather, builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('${snapshot.data?.getTemp.floor()}°', style: TextStyle(color: Colors.white, fontSize: 90, fontWeight:  FontWeight.bold)),
            );
        }
      }
      );
        
  }
}