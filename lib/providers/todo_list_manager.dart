import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_application/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    state = [
      ...state,
      TodoModel(
        id: const Uuid().v4(),
        description: description,
        isCompleted: false,
      ),
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (var element in state)
        if (element.id == id)
          TodoModel(
            id: element.id,
            description: element.description,
            isCompleted: !element.isCompleted,
          )
        else
          element,
    ];
  }

  void editTodo({required String id, required String newDescription}) {
    state = [
      for (var element in state)
        if (element.id == id)
          TodoModel(
            id: id,
            description: newDescription,
            isCompleted: element.isCompleted,
          )
        else
          element,
    ];
  }

  void removeTodo(TodoModel willRemoveTodo) {
    state = state.where((element) {
      return element.id != willRemoveTodo.id;
    }).toList();
  }

  int unCompletedTodos() {
    return state.where((element) {
      return !element.isCompleted;
    }).length;
  }
}
