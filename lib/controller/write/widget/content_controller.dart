import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mentalo/utils/control_file.dart';

class ContentWidgetController {
  RxInt selectEmotionIndex = 0.obs;
  RxString title = "".obs;
  RxString content = "".obs;
  final ImagePicker picker = ImagePicker();
  late XFile pickedImage;

  setSelectEmotionIndex(int index) {
    selectEmotionIndex.value = index;
  }

  getSelectEmotionIndex() {
    return selectEmotionIndex.value;
  }

  setTitle(String inputTitle) {
    title.value = inputTitle;
  }

  getTitle() {
    return title.value;
  }

  setContent(String inputContent) {
    content.value = inputContent;
  }

  getContent() {
    return content.value;
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = image;
    }
  }

  void saveToDiary(String weatherState) async {
    String currentDayForPath =
        DateFormat("yyyy년 M월 dd일").format(DateTime.now()); // 경로에 쓰일 현재 날짜
    String diarysJsonData = await loadFile("preview");

    Map<String, dynamic> coverData = {
      "title": title.value,
      "date": currentDayForPath,
      "image_path": pickedImage.path
    };

    Map<String, dynamic> diaryData = {
      "title": title.value,
      "content": content.value,
      "emotionIdx": selectEmotionIndex.value,
      "weather": weatherState
    }; // 일기 데이터

    String diaryDataString = jsonEncode(diaryData);
    String previewDiaryDataString = jsonEncode(coverData);

    if (diarysJsonData.isNotEmpty) {
      diarysJsonData = "$diarysJsonData,$previewDiaryDataString";
    } else {
      diarysJsonData = previewDiaryDataString;
    }

    print("미리보기 데이터 : $diarysJsonData");

    saveToFile("preview", diarysJsonData);
    saveToFile(currentDayForPath, diaryDataString);
  }
}
