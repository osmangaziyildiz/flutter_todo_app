import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_application/models/todo_model.dart';
import 'package:flutter_todo_application/providers/todo_list_manager.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(
  (ref) {
    return TodoListManager(
      [],
    );
  },
);

final unCompletedTodoProvider = Provider<int>(
  (ref) {
    final allTodos = ref.watch(todoListProvider);
    final count = allTodos.where((element) => !element.isCompleted).length;
    return count;
  },
);

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider<TodoListFilter>((ref) {
  return TodoListFilter.all;
});

final filteredListProvider = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.active:
      return todoList.where((element) => !element.isCompleted).toList();
    case TodoListFilter.completed:
      return todoList.where((element) => element.isCompleted).toList();
  }
});
