import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../config/app_theme.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  static const String _themeModeKey = 'theme_mode';

  final GetStorage _box = GetStorage();

  late ThemeMode themeMode;

  @override
  void onInit() {
    super.onInit();
    themeMode = _readThemeMode();
  }

  ThemeData get lightTheme => AppTheme.buildTheme(
        AppTheme.lightColors,
        Brightness.light,
      );

  ThemeData get darkTheme => AppTheme.buildTheme(
        AppTheme.darkColors,
        Brightness.dark,
      );

  AppColorScheme get colors {
    final base = _isDarkMode() ? AppTheme.darkColors : AppTheme.lightColors;
    return base;
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    _box.write(_themeModeKey, _modeToString(mode));
    update();
  }

  void toggleThemeMode() {
    setThemeMode(_isDarkMode() ? ThemeMode.light : ThemeMode.dark);
  }

  ThemeMode _readThemeMode() {
    final value = _box.read<String>(_themeModeKey);
    return _stringToMode(value);
  }

  bool _isDarkMode() {
    if (themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  String _modeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
      default:
        return 'light';
    }
  }

  ThemeMode _stringToMode(String? value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }
}
