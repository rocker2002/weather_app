import 'package:flutter/material.dart';

class WeatherWeek extends StatelessWidget {
  const WeatherWeek({super.key});

  Widget _buildWeatherRow(String day, String emoji, String temp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(day, style: const TextStyle(fontSize: 25)),
          Text(emoji, style: const TextStyle(fontSize: 25)),
          Text(temp, style: const TextStyle(fontSize: 25)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildWeatherRow("Monday", '🌩️', "2° -1°"),
        _buildWeatherRow("Tuesday", '🌩️', "8° 4°"),
        _buildWeatherRow("Wednesday", '🌩️', "11° 6°"),
      ],
    );
  }
}