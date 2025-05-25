import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather.dart';
class WeatherReport extends StatelessWidget{
  final Future<Weather>? currentWeather;

   const WeatherReport({
    super.key,
    required this.currentWeather,
    
  });
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                width: 250,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.grey[200], borderRadius: 
                  BorderRadius.circular(50), boxShadow: [
                    BoxShadow(color: Colors.black,
                     offset: Offset(1.0, 1.0), blurRadius: 1.0,
                     spreadRadius: BorderSide.strokeAlignOutside),
                     BoxShadow(color: Colors.white,
                     offset: Offset(-1.0, -1.0), blurRadius: 1.0,
                     spreadRadius: BorderSide.strokeAlignOutside)],
                 ),
                child: Column(
                  children: [
                    _weatherType(),
                    _weatherIcon(),
                    _weatherTemp(),
                  ],
                ),
              ),
              SizedBox(height: 50),
              _weatherCity(),
              SizedBox(height: 50),
              _weatherMaxMin()
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
            child: Text('${snapshot.data?.getWeather}', 
              style: GoogleFonts.montserrat(color: Colors.black, 
              fontSize: 40,  shadows: [Shadow(color: Colors.grey
              ,offset: Offset(0.5, 0.5), blurRadius: 1.0)])),
            );
        }
      }
      );
  }

  Widget _weatherIcon(){
    return FutureBuilder<Weather>(
      future: currentWeather, builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Image.network('http://openweathermap.org/img/w/${snapshot.data?.getWeatherIcon}.png')
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
            child: Text('${snapshot.data?.getCity}', style: GoogleFonts.montserrat(
              color: Colors.black, fontSize: 25, shadows: [Shadow(color: Colors.grey
              ,offset: Offset(0.5, 0.5), blurRadius: 1.0)])),
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
          return Text('${snapshot.data?.getTemp.round()}°', style: GoogleFonts.montserrat(
            color: Colors.black, fontSize: 90, shadows: [Shadow(color: Colors.grey
            ,offset: Offset(1.0, 1.0), blurRadius: 1.0)])); 
        }
      }
      );
        
  }

  Widget _weatherMaxMin(){
    return FutureBuilder<Weather>(
      future: currentWeather, builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }else{
          return Container(
            width: 250,
            padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[200], borderRadius: 
                  BorderRadius.circular(50), boxShadow: [
                    BoxShadow(color: Colors.black,
                     offset: Offset(1.0, 1.0), blurRadius: 1.0,
                     spreadRadius: BorderSide.strokeAlignOutside),
                     BoxShadow(color: Colors.white,
                     offset: Offset(-1.0, -1.0), blurRadius: 1.0,
                     spreadRadius: BorderSide.strokeAlignOutside)],
                     shape: BoxShape.rectangle,
                     ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Max: ${snapshot.data?.getMaxTemp.round()}°', style: GoogleFonts.montserrat(
              color: Colors.black, fontSize: 20, shadows: [Shadow(color: Colors.grey
              ,offset: Offset(1.0, 1.0), blurRadius: 1.0)])),
              SizedBox(width: 50,),
              Text('Min: ${snapshot.data?.getMinTemp.round()}°', style: GoogleFonts.montserrat(
              color: Colors.black, fontSize: 20, shadows: [Shadow(color: Colors.grey
              ,offset: Offset(1.0, 1.0), blurRadius: 1.0)])),
            ],
          ),
          );
        }
      }
      );
        
  }
}