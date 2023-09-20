import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalo/controller/write/widget/header_controller.dart';
import 'package:mentalo/models/weatherstate_model.dart';
import 'package:mentalo/pages/diary_list_page.dart';
import 'package:mentalo/utils/convert_weather_state_util.dart';

// 날씨의 상태
final List<WeatherState> weatherStateItems = [
  WeatherState(icon: Icons.sunny, state: "Sunny"),
  WeatherState(icon: Icons.cloud, state: "Cloudy"),
  WeatherState(icon: Icons.air, state: "Windy"),
  WeatherState(icon: Icons.umbrella, state: "Rainy"),
  WeatherState(icon: Icons.cloudy_snowing, state: "Snowy"),
  WeatherState(icon: Icons.thunderstorm, state: "Thunder"),
];

class HeaderWidget extends StatelessWidget {
  final HeaderWidgetController headerController;
  const HeaderWidget({Key? key, required this.headerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String currentDay = headerController.getCurrentDay();
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Row(children: [
                Obx(() {
                  return Icon(
                    convertStringToIcon(headerController.getWeatherState()),
                    color: Colors.white,
                  );
                }),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                )
              ]),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                        child: _WeatherDialog(
                            headerController: headerController)));
              },
            ),
            Center(
                child: Text(
              currentDay,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18),
            )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewDiaryListPage()));
              },
              child: const Icon(
                Icons.book,
                color: Colors.white,
              ),
            )
          ],
        ));
  }
}

class _WeatherDialog extends StatelessWidget {
  final HeaderWidgetController headerController;
  const _WeatherDialog({required this.headerController});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "오늘의 날씨는 어땠나요?",
            style: TextStyle(height: 3, fontSize: 18),
          ),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
              ),
              itemCount: weatherStateItems.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    headerController
                        .setWeatherState(weatherStateItems[index].state);
                    Navigator.pop(context);
                  },
                  child: Column(children: [
                    Icon(weatherStateItems[index].icon),
                    Text(weatherStateItems[index].state),
                  ]),
                );
              }),
        ],
      ),
    );
  }
}
