import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_application/models/todo_model.dart';
import 'package:flutter_todo_application/providers/all_providers.dart';
import 'package:flutter_todo_application/widgets/no_task_widget.dart';
import 'package:flutter_todo_application/widgets/text_field_widget.dart';
import 'package:flutter_todo_application/widgets/title_widget.dart';
import 'package:flutter_todo_application/widgets/todo_list_item_widget.dart';
import 'package:flutter_todo_application/widgets/toolbar_widget.dart';

class ToDoApp extends ConsumerWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TodoModel> allTodos = ref.watch(filteredListProvider);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        children: [
          const TitleWidget(),
          TextFieldWidget(),
          const SizedBox(height: 20),
          const ToolBarWidget(),
          if (allTodos.isEmpty)
            Container(
              height: MediaQuery.of(context).size.height / 2,
              alignment: Alignment.center,
              child: const NoTaskWidget(),
            )
          else
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                  onDismissed: (_) {
                    ref
                        .watch(todoListProvider.notifier)
                        .removeTodo(allTodos[i]);
                  },
                  key: ValueKey(allTodos[i].id),
                  child: TodoListItemWidget(item: allTodos[i])),
        ],
      ),
    );
  }
}
