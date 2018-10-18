import 'package:flutter/material.dart';

class Model {}

class Controller extends StatefulWidget {
  @override
  ControllerState createState() => ControllerState();
}

class ControllerState extends State<Controller> {
  Model _model;

  @override
  Widget build(BuildContext context) {
    return View(model: _model);
  }
}

class View extends StatelessWidget {
  final Model model;

  const View({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // can return both Controllers and Views
  }
}
