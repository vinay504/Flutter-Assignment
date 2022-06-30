

import 'package:assignment_flutter/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/todo.dart';
import '../../providers/todos.dart';
import '../../widgets/todo_form_widget.dart';

class AddTodoPage extends StatefulWidget {
  static const route = '/add_todo_page';
  // final Todo? todo;
  const AddTodoPage({Key? key}) : super(key: key);



  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padSixteen),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            InkWell(
              onTap: (){

                provider.selectDateTime(context);
              },
              child: TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() {
                      this.description = provider.dateTime.toString();

                    }),
                context: context,
                onSavedTodo: addTodo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState?.validate();
    final provider = Provider.of<TodosProvider>(context, listen: false);
    if (!isValid!) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        dateTime: DateFormat.yMd().add_jms().format(provider.dateTime),
        createdTime: DateTime.now(),
      );


      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
