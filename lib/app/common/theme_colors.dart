import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_theme.dart';
import '../controller/theme_controller.dart';

AppColorScheme get colors {
  final context = Get.context;
  if (context == null) {
    if (Get.isRegistered<ThemeController>()) {
      return ThemeController.to.colors;
    }
    return AppTheme.lightColors;
  }
  return Theme.of(context).extension<AppColorScheme>() ?? AppTheme.lightColors;
}
