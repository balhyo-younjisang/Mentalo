import 'package:flutter/material.dart';
import 'package:mentalo/widgets/write/header_widget.dart';
import 'package:mentalo/widgets/write/content_widget.dart';
import 'package:mentalo/controller/write/widget/header_controller.dart';
import 'package:mentalo/controller/write/widget/content_controller.dart';

class WriteDiaryPage extends StatelessWidget {
  final HeaderWidgetController headerController = HeaderWidgetController();
  final ContentWidgetController contentController = ContentWidgetController();

  WriteDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(children: [
            HeaderWidget(headerController: headerController),
            ContentWidget(
                headerController: headerController,
                contentController: contentController)
          ]),
        ),
      ),
    );
  }
}
