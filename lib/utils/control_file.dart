import 'dart:io';
import 'package:path_provider/path_provider.dart';

// 파일 경로를 생성하는 함수
Future<File> getFile(String fileName) async {
  final directory = await getApplicationDocumentsDirectory(); // 앱의 디렉토리 경로를 가져옴
  return File('${directory.path}/$fileName'); // 파일 경로와 파일 이름을 합쳐서 전체 파일 경로를 만듬
}

// 파일을 저장하는 함수
Future<void> saveToFile(String fileName, String content) async {
  final file = await getFile(fileName); // 파일 경로를 생성함
  await file.writeAsString(content); // 파일에 내용을 저장함
}

//파일을 불러오는 함수
Future<String> loadFile(String fileName) async {
  try {
    final file = await getFile(fileName); //파일을 불러옴
    String fileContents = await file.readAsString(); //불러온 파일의 데이터를 읽어옴
    return fileContents;
  } catch (e) {
    return '';
  }
}
