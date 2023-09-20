import 'dart:convert';

import 'package:mentalo/models/diary_model.dart';
import 'package:mentalo/utils/control_file.dart';

class ViewDiaryController {
  getDiaryContent(String date, String imagePath) async {
    String contentJsonData = await loadFile(date);
    Map<String, dynamic> contentData = jsonDecode(contentJsonData);

    return Diary(
        title: contentData["title"],
        content: contentData['content'],
        weatherState: contentData['weather'],
        selectEmotionIndex: contentData['emotionIdx'],
        imagePath: imagePath,
        date: date);
  }
}
