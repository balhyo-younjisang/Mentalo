import 'package:flutter/material.dart';

import 'package:mentalo/widgets/diary/calendar_widget.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: CalendarWidget()));
  }
}
