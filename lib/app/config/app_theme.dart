import 'package:flutter/material.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color mainColor;
  final Color backgroundColor;
  final Color textMainColor;
  final Color textSubColor;
  final Color lineColor;

  const AppColorScheme({
    required this.mainColor,
    required this.backgroundColor,
    required this.textMainColor,
    required this.textSubColor,
    required this.lineColor,
  });

  @override
  AppColorScheme copyWith({
    Color? mainColor,
    Color? backgroundColor,
    Color? textMainColor,
    Color? textSubColor,
    Color? lineColor,
  }) {
    return AppColorScheme(
      mainColor: mainColor ?? this.mainColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textMainColor: textMainColor ?? this.textMainColor,
      textSubColor: textSubColor ?? this.textSubColor,
      lineColor: lineColor ?? this.lineColor,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textMainColor: Color.lerp(textMainColor, other.textMainColor, t)!,
      textSubColor: Color.lerp(textSubColor, other.textSubColor, t)!,
      lineColor: Color.lerp(lineColor, other.lineColor, t)!,
    );
  }
}

class AppTheme {
  static const AppColorScheme lightColors = AppColorScheme(
    mainColor: Color(0xFF007AFF),
    backgroundColor: Color(0xFFF8F8F8),
    textMainColor: Color(0xFF333333),
    textSubColor: Color(0xFF999999),
    lineColor: Color(0xFFE4E4E4),
  );

  static const AppColorScheme darkColors = AppColorScheme(
    mainColor: Color(0xFF4DA3FF),
    backgroundColor: Color(0xFF121212),
    textMainColor: Color(0xFFE6E6E6),
    textSubColor: Color(0xFF9A9A9A),
    lineColor: Color(0xFF2A2A2A),
  );

  static ThemeData buildTheme(
    AppColorScheme colors,
    Brightness brightness,
  ) {
    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: 'PingFang',
      scaffoldBackgroundColor: colors.backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.mainColor,
        brightness: brightness,
      ),
      tabBarTheme: const TabBarThemeData(dividerHeight: 0.0),
      appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
      extensions: <ThemeExtension<dynamic>>[colors],
    );

    return base.copyWith(
      dividerColor: colors.lineColor,
      textTheme: base.textTheme.apply(
        bodyColor: colors.textMainColor,
        displayColor: colors.textMainColor,
      ),
    );
  }
}
