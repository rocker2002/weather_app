class Weather{
  late String weather;
  late String weatherIcon;
  late double mainTemp;
  late double maxTemp;
  late double minTemp;
  late String city;

  Weather({required this.weather, required this.weatherIcon, required this.mainTemp, 
  required this.maxTemp, required this.minTemp, required this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weather: json['weather'][0]['main'],
      weatherIcon: json['weather'][0]['icon'],
      mainTemp: json['main']['temp'],
      maxTemp: json['main']['temp_max'],
      minTemp: json['main']['temp_min'],
      city: json['name']
    );
  }

  String get getWeather{
    return weather;
  }
  String get getWeatherIcon{
    return weatherIcon;
  }

  double get getTemp{
    return mainTemp;
  }
  double get getMaxTemp{
    return maxTemp;
  }
  double get getMinTemp{
    return minTemp;
  }

  String get getCity{
    return city;
  }

  Map<String, dynamic> toJson() => {'weather': weather, 'weatherIcon': weatherIcon, 
  'mainTemp': mainTemp, 'maxTemp': maxTemp, 'minTemp': minTemp, 'city': city};
}