class Diary {
  late String title;
  late String content;
  late String date;
  late String weatherState;
  late int selectEmotionIndex;
  late String imagePath;

  Diary(
      {required this.title,
      required this.content,
      required this.date,
      required this.weatherState,
      required this.selectEmotionIndex,
      required this.imagePath});
}
