import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../utils/logger.dart';

class AppErrorHandler {
  AppErrorHandler._();

  /// 注册全局异常入口。
  ///
  /// 模板先统一收口到日志，后续项目可在这里接入 Sentry、Firebase Crashlytics
  /// 或团队自己的异常上报平台。
  static void register() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      Log.e(
        'FlutterError: ${details.exceptionAsString()}',
        details.exception,
        details.stack,
      );
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      Log.e('PlatformDispatcherError: $error', error, stack);
      return true;
    };
  }

  /// 包裹应用启动，兜底捕获异步 Zone 内未处理异常。
  static Future<void> run(Future<void> Function() body) {
    return runZonedGuarded<Future<void>>(
      body,
      (Object error, StackTrace stackTrace) {
        Log.e('runZonedGuardedError: $error', error, stackTrace);
      },
    ) ?? Future<void>.value();
  }
}
