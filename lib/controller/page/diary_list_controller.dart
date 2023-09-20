import 'dart:convert';
import 'package:mentalo/utils/control_file.dart';
import 'package:mentalo/models/preview_diary.dart';

// 수정할 사항 : 싱글톤 패턴 사용하기
class DiaryListController {
  List<PreviewDiary> diaryPreviews = [];

  getDiarys() {
    return diaryPreviews;
  }

  setDiarys() async {
    String diarysJsonData = await loadFile("preview");
    List decodeDiary = jsonDecode("[$diarysJsonData]");

    for (var preview in decodeDiary) {
      diaryPreviews.add(PreviewDiary(
          title: preview["title"],
          date: preview["date"],
          imagePath: preview['image_path']));
    }
    print(diaryPreviews);
  }
}
