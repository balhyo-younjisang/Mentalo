import 'package:flutter/material.dart';
import 'package:mentalo/pages/write_page.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "오늘의 기분은 어떠셨나요?",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w200),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WriteDiaryPage()));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 48, 210, 85),
                borderRadius: BorderRadius.circular(5)),
            child: const Text(
              "오늘의 일기 쓰러가기",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
