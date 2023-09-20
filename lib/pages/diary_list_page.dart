import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentalo/controller/page/diary_list_controller.dart';
import 'package:mentalo/models/preview_diary.dart';
import 'package:mentalo/pages/view_diary_page.dart';

class ViewDiaryListPage extends StatefulWidget {
  const ViewDiaryListPage({super.key});

  @override
  State<ViewDiaryListPage> createState() => _ViewDiaryListPageState();
}

class _ViewDiaryListPageState extends State<ViewDiaryListPage> {
  DiaryListController controller = DiaryListController();
  late List<PreviewDiary> previewDiary = [];

  Future<void> _initDiaryList() async {
    controller = DiaryListController();
    await controller.setDiarys();
    previewDiary = await controller.getDiarys();
    print("다이어리 : $previewDiary");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initDiaryList(),
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
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: GridView.builder(
                  itemCount: previewDiary.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewDiaryPage(
                                    previewDiary[index].date,
                                    previewDiary[index].imagePath)));
                      },
                      child: Column(
                        children: [
                          Image.file(File(previewDiary[index].imagePath)),
                          Text(
                            previewDiary[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(previewDiary[index].date,
                              style: const TextStyle(color: Colors.white))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   print("렌더링");
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: SafeArea(
  //       child: Container(
  //           width: double.infinity,
  //           height: double.infinity,
  //           padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  //           decoration: const BoxDecoration(
  //               gradient: LinearGradient(colors: [
  //             Color.fromARGB(195, 0, 64, 142),
  //             Color.fromARGB(255, 141, 176, 219)
  //           ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
  //           child: Container(
  //             margin: const EdgeInsets.all(5),
  //             child: GridView.builder(
  //                 itemCount: previewDiary.length,
  //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2,
  //                   childAspectRatio: 1 / 2,
  //                   mainAxisSpacing: 10,
  //                   crossAxisSpacing: 10,
  //                 ),
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return InkWell(
  //                     onTap: () {},
  //                     child: Column(
  //                       children: [
  //                         Image.file(File(previewDiary[index].imagePath)),
  //                         Text(
  //                           previewDiary[index].title,
  //                           style: const TextStyle(color: Colors.white),
  //                         ),
  //                         Text(previewDiary[index].date,
  //                             style: const TextStyle(color: Colors.white))
  //                       ],
  //                     ),
  //                   );
  //                 }),
  //           )),
  //     ),
  //   );
  // }
}
