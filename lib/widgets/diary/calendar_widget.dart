import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class CalendarWidgetController {
  List<String> week = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]; // 주일
  DateTime now = DateTime.now(); // 현재 날짜

  RxInt year = 0.obs; // 년
  RxInt month = 0.obs; // 달
  RxString monthString = "January".obs; // 영문으로 달 표시
  RxList days = [].obs; // 일

  // 현재 날짜인지 확인하는 함수
  bool isToday(int year, int month, int day) {
    if (year == DateTime.now().year &&
        month == DateTime.now().month &&
        day == DateTime.now().day) {
      return true;
    }
    return false;
  }

  // 선택한 날짜를 체크하는 함수
  void pickDate(int index) {
    for (var day in days) {
      day["picked"].value = false;
    }
    days[index]["picked"].value = true;
  }

  // 초기값을 설정하는 함수
  void calculateCalendarValue(int setYear, int setMonth) {
    // 초기값 설정
    year.value = setYear;
    month.value = setMonth;
    monthString.value = DateFormat.MMMM().format(DateTime(0, month.value));
    insertDays(year.value, month.value); // 달력 일 배열에 값 채워넣기
  }

  // 일 배열에 값을 넣는 함수
  void insertDays(int year, int month) {
    monthString.value = DateFormat.MMMM().format(DateTime(0, month));
    days.clear();

    // 해당 달에 맞추어 일 채우기
    int lastDay = DateTime(year, month + 1, 0).day;
    for (int day = 1; day <= lastDay; day++) {
      days.add({
        "year": year,
        "month": month,
        "day": day,
        "inMonth": true,
        "picked": false.obs,
        "emotion": Null
      });
    }

    /* 이번달 1일의 요일 : DateTime(year, month, 1).weekday 
      => 7이면(일요일) 상관x
      => 아니면 비어있는 요일만큼 지난달 채우기*/
    if (DateTime(year, month, 1).weekday != 7) {
      List lastMonth = [];
      int prevLastDay = DateTime(year, month, 0).day;

      for (int day = DateTime(year, month, 1).weekday - 1; day >= 0; day--) {
        lastMonth.add({
          "year": year,
          "month": month - 1,
          "day": prevLastDay - day,
          "inMonth": false,
          "picked": false.obs,
          "emotion": Null
        });
      }

      days = [...lastMonth, ...days].obs;
    }

    /*
      6줄을 유지하기 위해 남은 날 채우기
      => 6*7 = 42. 42개까지
    */
    List temp = [];
    for (int i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": year,
        "month": month + 1,
        "day": i,
        "inMonth": false,
        "picked": false.obs,
        "emotion": Null
      });
    }

    days = [...days, ...temp].obs;
  }
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarWidgetController controller = CalendarWidgetController();
  int year = DateTime.now().year;
  int month = DateTime.now().month;

  @override
  void initState() {
    super.initState();

    controller.calculateCalendarValue(year, month);
  }

  @override
  Widget build(BuildContext context) {
    controller.calculateCalendarValue(year, month);
    return Column(
      children: [
        CalendarHeaderWidget(controller: controller), // 달력 상단 , 컨트롤러 인스턴스 전달
        WeekWidget(controller: controller), // 달력 요일 표시, 컨트롤러 인스턴스 전달
        DayWidget(controller: controller) // 달력 일 표시, 컨트롤러 인스턴스 전달
      ],
    );
  }
}

// 달력 상단 위젯
class CalendarHeaderWidget extends StatelessWidget {
  final CalendarWidgetController controller;
  const CalendarHeaderWidget({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      IconButton(
        // 이전 달로 이동
        onPressed: () {
          if (controller.month.value == 1) {
            controller.month(12);
            controller.year -= 1;
          } else {
            controller.month -= 1;
          }
          controller.insertDays(controller.year.value, controller.month.value);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ),
      ),
      Column(
        children: [
          // Obx로 감싸 값이 바뀜에 따라 새로 렌더링
          // 달 표시
          Obx(() => Text(
                controller.month.value.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              )),
          //영문 표시
          Obx(() => Text(
                controller.monthString.value,
                style: const TextStyle(fontSize: 18),
              )),
        ],
      ),
      IconButton(
        // 다음 달로 이동
        onPressed: () {
          if (controller.month.value == 12) {
            controller.month(1);
            controller.year += 1;
          } else {
            controller.month += 1;
          }
          controller.insertDays(controller.year.value, controller.month.value);
        },
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: Colors.black,
        ),
      ),
    ]);
  }
}

// 주일 표시 위젯
class WeekWidget extends StatelessWidget {
  final CalendarWidgetController controller;
  const WeekWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 122, 122, 122))),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < controller.week.length; i++)
            Container(
              width: 30,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                // 일요일은 빨강, 토요일은 파랑, 그 외는 검정으로 표시
                controller.week[i],
                style: TextStyle(
                  fontSize: 10,
                  color: i == 0
                      ? Colors.red
                      : i == controller.week.length - 1
                          ? Colors.blue
                          : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            )
        ],
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final CalendarWidgetController controller;
  const DayWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 350,
        // Obx로 감싸 값이 바뀜에 따라 새로 렌더링
        child: Obx(
          () => Wrap(
            children: [
              for (int day = 0; day < controller.days.length; day++)
                InkWell(
                    onTap: () => controller.pickDate(day),
                    child: Container(
                      width: 50,
                      height: 60,
                      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 190, 190, 190),
                            width: 0.2),
                        // color: controller.days[day]["picked"].value
                        //     ? Colors.red
                        //     : Colors.transparent,
                      ),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Icon(
                            controller.isToday(
                                        controller.days[day]["year"],
                                        controller.days[day]["month"],
                                        controller.days[day]["day"]) ||
                                    controller.days[day]["picked"].value
                                ? Icons.check
                                : null,
                            color: controller.days[day]["picked"].value
                                ? const Color.fromARGB(255, 191, 148, 148)
                                : const Color.fromARGB(255, 255, 17, 0),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                              child: Text(
                                controller.days[day]["day"].toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  // 현재 달만 검은색으로 표시, 이전 달과 다음 달의 일들은 회색으로
                                  color: controller.days[day]["inMonth"]
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ))
                        ],
                      ),
                    ))
            ],
          ),
        ));
  }
}
