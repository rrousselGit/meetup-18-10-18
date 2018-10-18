import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meetup/localization.dart';
import 'package:meetup/one-widget-one-feature/good.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('here');
    if (const bool.fromEnvironment('PLATFORM_IS_ANDROID')) {
      print("there");
    }
    return MaterialApp(
      localizationsDelegates: [
        DemoDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      routes: {
        '/one-widget-one-feature': (context) => TodoList(),
      },
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      ListTile(
        onTap: () => Navigator.pushNamed(context, '/one-widget-one-feature'),
        title: Text('One widget = One feature'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.separated(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
