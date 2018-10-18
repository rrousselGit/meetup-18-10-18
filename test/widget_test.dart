import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup/one-feature-one-widget/good-mock.dart';
import 'package:meetup/one-feature-one-widget/good-usage_test.dart';
import 'package:meetup/test_sample/widget.dart';

void main() {
  testWidgets('Foo', (tester) async {
    // DON'T test the state
    // DO test the generated widgets

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: RepaintBoundary(child: Hello()))));

    expect(find.text('0'), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);

    await tester.tap(find.byType(Text));
    await tester.pump();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  // golden tests are easy way to test the rendering
  testWidgets('golden', (tester) async {
    await tester.pumpWidget(
        Center(child: SizedBox(width: 100.0, height: 100.0, child: Sushi())));

    await expectLater(
        find.byType(Container).first, matchesGoldenFile('sushi.png'));
  });

  testWidgets('Configurations', (tester) async {
    // DON'T manually find the ConfigurationsState and test its values
    // DO use the "of"
    ConfigurationData data;
    await tester.pumpWidget(
      Configurations(
        child: Builder(
          builder: (context) {
            data = Configurations.of(context);
            return Container();
          },
        ),
      ),
    );

    expect(data.foo, equals("Hello World"));
  });

  // Rappel: Injecter les dependences via le contexte permet de facilement testers
  testWidgets('Usage', (tester) async {
    await tester.pumpWidget(
      Configurations.mock(
        configurations: ConfigurationData(foo: "42"),
        child: MaterialApp(home: Usage()),
      ),
    );

    expect(find.text('42'), findsOneWidget);
  });
}
