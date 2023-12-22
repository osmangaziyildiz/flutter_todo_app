import 'package:flutter/material.dart';

class NoTaskWidget extends StatelessWidget {
  const NoTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('There is no task to view!'),
        Image.asset('assets/noTaskImage.png', height: 200)
      ],
    );
  }
}
