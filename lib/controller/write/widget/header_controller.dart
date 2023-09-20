import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HeaderWidgetController {
  RxString weatherState = "sunny".obs;

  String getCurrentDay() {
    String currentDay = DateFormat("yyyy년 M월 dd일").format(DateTime.now());
    return currentDay;
  }

  void setWeatherState(String state) {
    weatherState.value = state;
  }

  String getWeatherState() {
    return weatherState.value;
  }
}
