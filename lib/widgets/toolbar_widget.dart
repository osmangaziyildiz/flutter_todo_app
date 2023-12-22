import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_application/providers/all_providers.dart';

TodoListFilter _currentFilter = TodoListFilter.all;

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({super.key});

  Color changeColor(TodoListFilter givenFilter) {
    return _currentFilter == givenFilter ? Colors.amber : Colors.grey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ucTodo = ref.watch(unCompletedTodoProvider);
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            ucTodo == 0 ? 'All tasks completed' : 'You have $ucTodo tasks',
          ),
        ),
        Tooltip(
          message: 'All todos',
          child: TextButton(
            onPressed: () {
              () {
                ref.watch(todoListFilter.notifier).state = TodoListFilter.all;
              }();
            },
            style: TextButton.styleFrom(
                foregroundColor: changeColor(TodoListFilter.all)),
            child: const Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only Uncompleted todos',
          child: TextButton(
            onPressed: () {
              () {
                ref.watch(todoListFilter.notifier).state =
                    TodoListFilter.active;
              }();
            },
            style: TextButton.styleFrom(
                foregroundColor: changeColor(TodoListFilter.active)),
            child: const Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Only Completed todos',
          child: TextButton(
            onPressed: () {
              () {
                ref.watch(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              }();
            },
            style: TextButton.styleFrom(
                foregroundColor: changeColor(TodoListFilter.completed)),
            child: const Text('Completed'),
          ),
        )
      ],
    );
  }
}
