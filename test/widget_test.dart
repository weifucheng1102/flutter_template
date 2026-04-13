import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template/page/launch/page_config.dart';

void main() {
  testWidgets('PageConfig renders child widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PageConfig(
          child: Text('page-config-child'),
        ),
      ),
    );

    expect(find.text('page-config-child'), findsOneWidget);
  });
}
