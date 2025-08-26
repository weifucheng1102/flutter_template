import 'package:logger/logger.dart';

/// 全局日志工具，只对 message 换行，保留 logger 格式
class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // 每行最大显示宽度（按字符宽度计）
  static const int _maxWidth = 120;

  // ============================
  // 内部方法：按字符宽度换行
  // 中文/全角字符宽度 = 2, 英文/半角 = 1
  // ============================
  static String _wrapMessage(String message) {
    final buffer = StringBuffer();
    int width = 0;

    for (int i = 0; i < message.length; i++) {
      final char = message[i];
      final charWidth = RegExp(r'[^\x00-\xff]').hasMatch(char) ? 2 : 1;

      if (width + charWidth > _maxWidth) {
        buffer.writeln();
        width = 0;
      }

      buffer.write(char);
      width += charWidth;
    }

    return buffer.toString();
  }

  // ============================
  // 公共方法
  // ============================

  /// debug 日志
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(_wrapMessage(message.toString()),
        error: error, stackTrace: stackTrace);
  }

  /// info 日志
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(_wrapMessage(message.toString()),
        error: error, stackTrace: stackTrace);
  }

  /// warning 日志
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(_wrapMessage(message.toString()),
        error: error, stackTrace: stackTrace);
  }

  /// error 日志
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(_wrapMessage(message.toString()),
        error: error, stackTrace: stackTrace);
  }
}
