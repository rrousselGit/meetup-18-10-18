import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup/one-feature-one-widget/good-mock.dart';

// main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Configurations(
      child: MaterialApp(/* ... */),
    );
  }
}

// somewhere

class Usage extends StatelessWidget {
  Widget build(BuildContext context) {
    // automatic reload on configurations change
    return Text(Configurations.of(context).foo);
  }
}

void main() {
  testWidgets('Foo', (tester) async {
    await tester.pumpWidget(
      Configurations.mock(
        configurations: ConfigurationData(foo: "42"),
        child: MaterialApp(home: Usage()),
      ),
    );

    expect(find.text('42'), findsOneWidget);
  });
}
