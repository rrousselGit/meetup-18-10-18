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
  UnmodifiableListView<Todo> _todos = UnmodifiableListView([]);

  void _getCheckHandler(Todo todo) {
    setState(() {
      _todos = UnmodifiableListView(_todos.map(
        (t) => t.id == todo.id ? todo.copyWith(done: !todo.done) : t,
      ));
    });
  }

  void _getDismissHandler(Todo todo) {
    setState(() {
      _todos = UnmodifiableListView(
        _todos.toList()..removeWhere((t) => t.id == todo.id),
      );
    });
  }

  void _onAddTodo(Todo todo) {
    setState(() {
      _todos = UnmodifiableListView(
        _todos.toList()..add(todo),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Has no UI logic. Only pass data and receive events
    return _TodoListView(
      todos: _todos,
      onRemoveTodo: _getDismissHandler,
      onCheckTodo: _getCheckHandler,
      onAddTodo: _onAddTodo,
    );
  }
}

int _id = 0;

class _TodoListView extends StatelessWidget {
  final void Function(Todo) onAddTodo;
  final void Function(Todo) onRemoveTodo;
  final void Function(Todo) onCheckTodo;

  const _TodoListView({
    Key key,
    @required UnmodifiableListView<Todo> todos,
    @required this.onAddTodo,
    @required this.onRemoveTodo,
    @required this.onCheckTodo,
  })  : _todos = todos,
        super(key: key);

  final UnmodifiableListView<Todo> _todos;

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
          return TodoItem(
            key: ObjectKey(todo.id),
            todo: todo,
            onRemove: (_) => onRemoveTodo(todo),
            onDoneChange: (_) => onCheckTodo(todo),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddTodo(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _onAddTodo(BuildContext context) async {
    final text = (await showDialog<String>(
      context: context,
      builder: (context) => NewTodoDialog(),
    ))
        .trim();

    if (text != null && text.length > 0) {
      onAddTodo(Todo(done: false, id: _id++, name: text));
    }
  }
}

class NewTodoDialog extends StatefulWidget {
  const NewTodoDialog({
    Key key,
  }) : super(key: key);

  @override
  NewTodoDialogState createState() {
    return new NewTodoDialogState();
  }
}

class NewTodoDialogState extends State<NewTodoDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("New todo"),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (res) => Navigator.of(context).pop(res),
            controller: controller,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
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
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key key,
    this.onDoneChange,
    @required this.onRemove,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;
  final void Function(DismissDirection) onRemove;
  final void Function(bool) onDoneChange;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: onRemove,
      child: CheckboxListTile(
        value: todo.done,
        onChanged: onDoneChange,
        title: Text(todo.name),
      ),
    );
  }
}
