import 'package:flutter/material.dart';

import 'package:mentalo/widgets/home/moon_widget.dart';
import 'package:mentalo/widgets/home/button_widget.dart';
import 'package:mentalo/widgets/home/tree_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(238, 0, 64, 142),
        Color.fromARGB(255, 141, 176, 219)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [MoonWidget(), ButtonWidget(), TreeWidget()],
      ),
    );
  }
}
