import 'package:flutter/material.dart';

class ConfigurationData {
  final String foo;

  ConfigurationData({this.foo});
}

class Configurations extends StatefulWidget {
  final Widget child;
  final ConfigurationData _mock;

  const Configurations({Key key, this.child})
      : _mock = null,
        super(key: key);

  Configurations.mock({Key key, ConfigurationData configurations, this.child})
      : _mock = configurations,
        super(key: key);

  static ConfigurationData of(BuildContext context) {
    _ConfigurationsInherited conf =
        context.inheritFromWidgetOfExactType(_ConfigurationsInherited);
    return conf.configurations;
  }

  @override
  _ConfigurationsState createState() => _ConfigurationsState();
}

class _ConfigurationsState extends State<Configurations> {
  ConfigurationData configurations;

  @override
  void initState() {
    super.initState();
    configurations = ConfigurationData(
      foo: "Hello World",
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ConfigurationsInherited(
      configurations: widget._mock ?? configurations,
      child: widget.child,
    );
  }
}

class _ConfigurationsInherited extends InheritedWidget {
  final ConfigurationData configurations;

  _ConfigurationsInherited({this.configurations, Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_ConfigurationsInherited oldWidget) {
    return configurations != oldWidget.configurations;
  }
}
