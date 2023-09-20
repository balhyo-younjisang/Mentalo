import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalo/pages/diary_list_page.dart';
import 'package:mentalo/controller/write/widget/content_controller.dart';
import 'package:mentalo/controller/write/widget/header_controller.dart';

final List emotionItemList = [0xec73, 0xe3fe, 0xe57a, 0xe57c, 0xf387];

class ContentWidget extends StatefulWidget {
  final ContentWidgetController contentController;
  final HeaderWidgetController headerController;

  const ContentWidget(
      {Key? key,
      required this.contentController,
      required this.headerController})
      : super(key: key);

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  final _titleEditController = TextEditingController();
  final _contentEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        EmotionWidget(contentController: widget.contentController),
        Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              controller: _titleEditController,
              onChanged: (value) {
                widget.contentController.setTitle(value);
              },
              maxLength: 10,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.0)),
                  border: OutlineInputBorder(),
                  labelText: '일기 제목을 입력해주세요.',
                  labelStyle: TextStyle(color: Colors.white)),
            )),
        Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextField(
              controller: _contentEditController,
              onChanged: (value) {
                widget.contentController.setContent(value);
              },
              maxLength: 120,
              minLines: 10,
              maxLines: 12,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0)),
                border: OutlineInputBorder(),
                labelText: '일기 내용을 입력해주세요.',
                labelStyle: TextStyle(color: Colors.white),
              ),
            )),
        Container(
            margin: const EdgeInsets.only(top: 50),
            child: ElevatedButton.icon(
              onPressed: () async {
                await widget.contentController.pickImage();
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("커버 사진 업로드"),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 50))),
            )),
        ElevatedButton.icon(
          onPressed: () {
            String weatherState = widget.headerController.weatherState.value;
            widget.contentController.saveToDiary(weatherState);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewDiaryListPage()));
          },
          icon: const Icon(Icons.save),
          label: const Text("오늘의 일기 저장"),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 50))),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleEditController.dispose();
    _contentEditController.dispose();
    super.dispose();
  }
}

class EmotionWidget extends StatelessWidget {
  final ContentWidgetController contentController;
  const EmotionWidget({super.key, required this.contentController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "오늘 하루의 기분은 어땠나요?",
        style: TextStyle(color: Colors.white),
      ),
      GridView.builder(
        shrinkWrap: true,
        itemCount: emotionItemList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              contentController.setSelectEmotionIndex(index);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Obx(() {
                  return Icon(
                    IconData(emotionItemList[index],
                        fontFamily: 'MaterialIcons'),
                    color: index == contentController.getSelectEmotionIndex()
                        ? Colors.deepPurple
                        : Colors.white,
                  );
                })
              ]),
            ),
          );
        },
      )
    ]);
  }
}
