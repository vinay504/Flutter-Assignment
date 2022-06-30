import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todos.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final BuildContext context;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.context,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>

      SingleChildScrollView(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildDateTime(),
            const SizedBox(height: 16),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() =>


      TextFormField(
        maxLines: 1,
        initialValue: title,

        onChanged: onChangedTitle,
        validator: (title) {
          if (title == null) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Task Name',
        ),
      );

  Widget buildDateTime() {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    return TextFormField(
      maxLines: 1,
      initialValue: description,
      onChanged: onChangedDescription,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Date and Time',
      ),
      enabled: false,

    );
  }


  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedTodo,
          child: const Text('Save'),
        ),
      );
}
