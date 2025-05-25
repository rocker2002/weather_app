import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/search_delegate.dart';
import '../widgets/weather_report.dart';




Future<Position> _getLocation() async{
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if(!serviceEnabled){
    return Future.error("Location is disabled! Can't access current Location.");
  }

  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error("Location request was denied!");
    }
  }
  if(permission == LocationPermission.deniedForever){
    return Future.error("Request is permanently denied!");
  }
  return await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.best));
}


class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  WeatherService weather = WeatherService();
  static final String? apiKey = dotenv.env['API_KEY'];
  late Future<Weather>? currentWeather;
  Future<Position>? currentPosition;
  late String formattedDate;
  late String formattedTime;
  late String dayName;

  void _updatedWeatherForLocation(double lat, double long){
    setState(() {
      currentWeather = weather.fetchWeather(lat, long, apiKey);
    });
  }
  
  @override
  void initState(){
    super.initState();
    DateTime now = DateTime.now();
  
    formattedDate = DateFormat('dd-MM-yyyy').format(now);
  
  
    formattedTime = DateFormat('HH:mm').format(now);
   
    dayName = DateFormat('EEEE').format(now); 
    currentPosition = _getLocation();
    currentWeather = currentPosition?.then((pos)=>weather.fetchWeather(pos.latitude, pos.longitude, apiKey));
  }

  IconButton _buildSearchButton(BuildContext context){
    return IconButton(onPressed: () async { 
              final selectedLocation = await showSearch<Location?>(
              context: context,
              delegate: LocationSearchDelegate(searchFunction: LocationService.fetchLocation,)
            );
              if(selectedLocation != null){
                _updatedWeatherForLocation(selectedLocation.lat, selectedLocation.lng);
              }
            },
            icon: Icon(Icons.search, shadows: [Shadow(color: Colors.grey
            ,offset: Offset(0.5, 0.5), blurRadius: 1.0)],));
            
  }


  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                child: Text('$dayName, $formattedDate', 
                style: GoogleFonts.montserrat(fontSize: 16, 
                color: Colors.black, shadows: [Shadow(color: Colors.grey
                , offset: Offset(0.5, 0.5), blurRadius: 1.0)]))
                ),
                Container(
                  decoration: BoxDecoration(
                  color: Colors.grey[200],
                   boxShadow: [
                    BoxShadow(color: Colors.black,
                     offset: Offset(1.0, 1.0), 
                     blurRadius: 1.0),
                     BoxShadow(color: Colors.white,
                     offset: Offset(-1.0, -1.0), blurRadius: 1.0)],
                     shape: BoxShape.circle,
                     backgroundBlendMode: BlendMode.darken
                     ),
                  child:  Builder(
                  builder: (context)=> _buildSearchButton(context),
                ),
                )
           
            ],
            ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(formattedTime, style: GoogleFonts.montserrat(color: Colors.black, 
                fontWeight: FontWeight.bold, fontSize: 20)),
                Expanded(
                  child: WeatherReport(currentWeather:  currentWeather),
                ),
              ],
            ),
          ),
        ),
    );
  }
  
}