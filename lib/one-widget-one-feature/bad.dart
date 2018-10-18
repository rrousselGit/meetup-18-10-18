import 'dart:collection';

import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String name;
  final bool done;

  Todo({this.id, this.name, this.done});

  Todo copyWith({bool done}) {
    return Todo(
      id: id,
      name: name,
      done: done,
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int _id = 0;
  UnmodifiableListView<Todo> _todos = UnmodifiableListView([]);

  void Function(bool) _getCheckHandler(Todo todo) {
    return (bool done) {
      setState(() {
        _todos = UnmodifiableListView(_todos.map(
          (t) => t.id == todo.id ? todo.copyWith(done: done) : t,
        ));
      });
    };
  }

  void Function(DismissDirection) _getDismissHandler(Todo todo) {
    return (_) {
      setState(() {
        _todos = UnmodifiableListView(
          _todos.toList()..removeWhere((t) => t.id == todo.id),
        );
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.separated(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Dismissible(
            key: ObjectKey(todo.id),
            onDismissed: _getDismissHandler(todo),
            child: CheckboxListTile(
              value: todo.done,
              onChanged: _getCheckHandler(todo),
              title: Text(todo.name),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTodo,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onAddTodo() async {
    final text = (await showDialog<String>(
      context: context,
      builder: (context) {
        final textController = TextEditingController();
        return SimpleDialog(
          title: Text("New todo"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (res) => Navigator.of(context).pop(res),
                controller: textController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pop(textController.text),
                  child: Text("OK"),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        );
      },
    ))
        ?.trim();

    if (text != null && text.length > 0) {
      setState(() {
        _todos = UnmodifiableListView(
          _todos.toList()
            ..add(
              new Todo(done: false, id: _id++, name: text),
            ),
        );
      });
    }
  }
}
