import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget {
  const TreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Stack(alignment: Alignment.bottomLeft, children: [
        Image(
          image: AssetImage('assets/mountain.png'),
        ),
        Image(image: AssetImage('assets/tree.png'))
      ]),
    );
  }
}
