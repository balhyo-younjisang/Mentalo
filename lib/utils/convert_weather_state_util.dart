import 'package:flutter/material.dart';

IconData convertStringToIcon(String state) {
  Map<String, IconData> states = {
    "Sunny": Icons.sunny,
    "Windy": Icons.air,
    "Cloudy": Icons.cloud,
    "Rainy": Icons.umbrella,
    "Snowy": Icons.cloudy_snowing,
    "Thunder": Icons.thunderstorm
  };
  IconData conformIcon = Icons.sunny;

  states.forEach((key, value) {
    if (state == key) conformIcon = value;
  });

  return conformIcon;
}
