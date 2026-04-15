import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:flutter_template/app/controller/theme_controller.dart';
import 'package:flutter_template/page/launch/launch_page.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    if (!Get.isRegistered<ThemeController>()) {
      Get.put(ThemeController());
    }
  });

  testWidgets('LaunchPage renders main navigation shell',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LaunchPage(),
      ),
    );

    expect(find.text('工作台'), findsOneWidget);
    expect(find.text('主题'), findsOneWidget);
    expect(find.text('设置'), findsOneWidget);
  });
}
