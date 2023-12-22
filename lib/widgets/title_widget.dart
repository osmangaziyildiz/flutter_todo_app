import 'package:flutter/material.dart';
import 'package:flutter_todo_application/constants/constants.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text('To Do App',
          textAlign: TextAlign.center, style: Constants.homeScreenText),
    );
  }
}
