import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Foo extends StatefulWidget {
  const Foo({Key key}) : super(key: key);

  @override
  FooState createState() {
    return new FooState();
  }
}

class FooState extends State<Foo> {
  final ValueNotifier<int> _counter = ValueNotifier(0);

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
    // no more setState
    _counter.value++;
  }
}

class Counter extends StatelessWidget {
  final ValueListenable value;

  const Counter({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (context, value, child) => Text(value.toString()),
    );
  }
}
