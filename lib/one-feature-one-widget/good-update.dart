import 'dart:async';

import 'package:flutter/material.dart';

class ConfigurationData {
  final String foo;

  ConfigurationData({this.foo});
}

class Configurations extends StatefulWidget {
  final Widget child;

  const Configurations({Key key, this.child}) : super(key: key);

  static ConfigurationData of(BuildContext context) {
    _ConfigurationsInherited conf =
        context.inheritFromWidgetOfExactType(_ConfigurationsInherited);
    return conf.configurations;
  }

  @override
  _ConfigurationsState createState() => _ConfigurationsState();
}

class _ConfigurationsState extends State<Configurations> {
  Stream<ConfigurationData> _confs;

  @override
  void initState() {
    super.initState();
    _confs = _watchConfs();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConfigurationData>(
      stream: _confs,
      builder: (context, snapshot) {
        return _ConfigurationsInherited(
          configurations: snapshot.requireData,
          child: widget.child,
        );
      },
    );
  }

  Stream<ConfigurationData> _watchConfs() async* {
    while (true) {
      yield await _fetchConfs();
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<ConfigurationData> _fetchConfs() {}
}

class _ConfigurationsInherited extends InheritedWidget {
  final ConfigurationData configurations;

  _ConfigurationsInherited({this.configurations, Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_ConfigurationsInherited oldWidget) {
    return configurations.foo != oldWidget.configurations.foo;
  }
}
