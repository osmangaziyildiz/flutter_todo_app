import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_application/providers/all_providers.dart';

class TextFieldWidget extends ConsumerWidget {
  TextFieldWidget({super.key});

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: textFieldController,
      onSubmitted: (newToDo) {
        if (newToDo.length > 3) {
          ref.watch(todoListProvider.notifier).addTodo(newToDo);
        }
      },
      decoration: const InputDecoration(
          hintText: 'What are you doing today?',
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          icon: Icon(Icons.add)),
    );
  }
}
