import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_application/models/todo_model.dart';
import 'package:flutter_todo_application/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  final TodoModel item;
  const TodoListItemWidget({super.key, required this.item});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textEditingController;
  late bool _hasFocus = false;
  @override
  void initState() {
    _textFocusNode = FocusNode();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });
        }
        ref.watch(todoListProvider.notifier).editTodo(
              id: widget.item.id,
              newDescription: _textEditingController.text,
            );
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _textFocusNode.requestFocus();
            _textEditingController.text = widget.item.description;
          });
        },
        leading: Checkbox(
          value: widget.item.isCompleted,
          onChanged: (value) {
            ref.watch(todoListProvider.notifier).toggleTodo(widget.item.id);
          },
        ),
        title: !_hasFocus
            ? Text(widget.item.description)
            : TextField(
                controller: _textEditingController,
                focusNode: _textFocusNode,
              ),
      ),
    );
  }
}
