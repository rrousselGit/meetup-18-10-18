import 'package:flutter/material.dart';

class Constant extends StatelessWidget {
  final int props;

  const Constant({Key key, this.props}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: Colors.red,
          padding: const EdgeInsets.all(8.0),
          child: Text('I never ever change'),
        ),
        Text('value: $props'),
      ],
    );
  }
}

/* BAD: */

class ConstantBad extends StatelessWidget {
  final int props;

  // break hot-reload
  final Widget _constant = Container(
    color: Colors.red,
    padding: const EdgeInsets.all(8.0),
    child: Text('I never ever change'),
  );

  // const constructors no more possible
  ConstantBad({Key key, this.props}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _constant,
        Text('value: $props'),
      ],
    );
  }
}

/* GOOD: */

class ConstantGood extends StatelessWidget {
  final int props;

  const ConstantGood({Key key, this.props}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // always reuse the exact same widget instance
        const _Constant(),
        Text('value: $props'),
      ],
    );
  }
}

class _Constant extends StatelessWidget {
  const _Constant({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(8.0),
      child: Text('I never ever change'),
    );
  }
}
