import 'package:flutter/widgets.dart';
import 'package:meetup/one-feature-one-widget/bad.dart';

class ConfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(configurations.foo);
  }
}

class StaticFunction extends StatefulWidget {
  @override
  _StaticFunctionState createState() => _StaticFunctionState();
}

class _StaticFunctionState extends State<StaticFunction> {
  Future<int> count;

  @override
  void initState() {
    count = getItemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {}
}
