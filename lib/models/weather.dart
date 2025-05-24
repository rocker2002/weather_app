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