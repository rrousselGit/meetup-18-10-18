import 'package:flutter/material.dart';

class Hello extends StatefulWidget {
  @override
  _HelloState createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  /* Private ! */
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onIncrement,
      child: Text(_counter.toString()),
    );
  }

  // private too !
  void _onIncrement() {
    setState(() {
      _counter++;
    });
  }
}

class Sushi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.green.shade900,
      ),
    );
  }
}
