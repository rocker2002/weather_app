import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location_service.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/search_delegate.dart';
import '../widgets/weather_report.dart';
import '../widgets/weather_week.dart';



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
  
  void _updatedWeatherForLocation(double lat, double long){
    setState(() {
      currentWeather = weather.fetchWeather(lat, long, apiKey);
    });
  }
  
  @override
  void initState(){
    super.initState();
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
            icon: Icon(Icons.search));
  }


  @override
  Widget build(BuildContext context){
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: [
            Builder(
              builder: (context)=> _buildSearchButton(context)
            )

          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: WeatherReport(currentWeather: currentWeather),
                ),
                Expanded(
                  child: WeatherWeek()
                )
              ],
            ),
          ),
        ),
    );
  }
  
}