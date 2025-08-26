import 'package:logger/logger.dart';

/// 全局日志工具
class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // 展示调用栈行数
      errorMethodCount: 8, // 错误日志展示调用栈行数
      lineLength: 80, // 每行长度
      colors: true, // 彩色日志
      printEmojis: true, // 是否显示 emoji
      printTime: true, // 是否显示时间
    ),
  );

  /// debug 日志
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// info 日志
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// warning 日志
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// error 日志
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
