

import 'package:flutter/material.dart';

import '../../widgets/completed_list_widget.dart';
import '../../widgets/todo_list_widget.dart';
import 'add_todo_page.dart';

class Todo extends StatefulWidget {
  static const route = '/todo';
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => addTodo(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void addTodo(BuildContext context) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    ),
  );
}
