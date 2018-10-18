import 'package:flutter/material.dart';

class Foo extends StatefulWidget {
  const Foo({Key key}) : super(key: key);

  @override
  FooState createState() {
    return new FooState();
  }
}

class FooState extends State<Foo> {
  int _counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Counter(value: _counter),
        RaisedButton(
          onPressed: _increment,
        )
      ],
    );
  }

  void _increment() {
    setState(() {
      _counter++;
    });
  }
}

class Counter extends StatelessWidget {
  final int value;

  const Counter({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(value.toString());
  }
}
