import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget {
  const TreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 150, 0),
      child: const Image(image: AssetImage('assets/tree.png')),
    );
  }
}
