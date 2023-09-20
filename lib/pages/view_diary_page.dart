import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentalo/controller/page/view_diary_controller.dart';
import 'package:mentalo/models/diary_model.dart';
import 'package:mentalo/utils/convert_weather_state_util.dart';

final List emotionItemList = [0xec73, 0xe3fe, 0xe57a, 0xe57c, 0xf387];

class ViewDiaryPage extends StatefulWidget {
  final String diaryDate;
  final String imagePath;

  const ViewDiaryPage(this.diaryDate, this.imagePath, {super.key});

  @override
  State<ViewDiaryPage> createState() => _ViewDiaryPageState();
}

class _ViewDiaryPageState extends State<ViewDiaryPage> {
  late Diary diary;

  Future<void> _initDiary() async {
    ViewDiaryController controller = ViewDiaryController();
    diary =
        await controller.getDiaryContent(widget.diaryDate, widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initDiary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Text("Loading...");
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(195, 0, 64, 142),
                  Color.fromARGB(255, 141, 176, 219)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.file(
                    File(diary.imagePath),
                    width: 300,
                    height: 180,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        convertStringToIcon(diary.weatherState),
                        color: Colors.white,
                      ),
                      Text(
                        diary.date,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(
                        IconData(emotionItemList[diary.selectEmotionIndex],
                            fontFamily: 'MaterialIcons'),
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    margin:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
                    child: TextField(
                      controller: TextEditingController(text: diary.title),
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    margin:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: diary.content),
                      readOnly: true,
                      minLines: 10,
                      maxLines: 12,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          counterStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0)),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
