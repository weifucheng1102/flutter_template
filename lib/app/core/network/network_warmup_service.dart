import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../config/app_config.dart';
import '../../utils/logger.dart';

class NetworkWarmupService {
  NetworkWarmupService._();

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 3000),
      receiveTimeout: const Duration(milliseconds: 3000),
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  static Future<bool>? _pendingFuture;
  static bool _hasCompletedWarmup = false;

  static bool get isEnabled =>
      Platform.isIOS && AppConfig.networkWarmupUrl.trim().isNotEmpty;

  static bool get hasCompletedWarmup => _hasCompletedWarmup;

  /// 用一个轻量请求提前触发 iOS 首次网络访问授权。
  ///
  /// 这里建议改成你自己的健康检查接口，不要长期依赖第三方地址。
  static Future<bool> ensureReady({bool force = false}) {
    if (!isEnabled) {
      return Future<bool>.value(true);
    }

    if (_hasCompletedWarmup && !force) {
      return Future<bool>.value(true);
    }

    if (_pendingFuture != null && !force) {
      return _pendingFuture!;
    }

    _pendingFuture = _warmup().whenComplete(() {
      _pendingFuture = null;
    });
    return _pendingFuture!;
  }

  static Future<bool> _warmup() async {
    final String url = AppConfig.networkWarmupUrl;

    for (int attempt = 0; attempt < 3; attempt++) {
      try {
        await _dio.get<dynamic>(
          url,
          options: Options(
            responseType: ResponseType.plain,
            followRedirects: false,
          ),
        );
        _hasCompletedWarmup = true;
        Log.i('网络预热成功: $url');
        return true;
      } catch (error) {
        Log.w('网络预热失败，第 ${attempt + 1} 次: $error');

        // 第一次失败通常就是系统弹窗刚弹出，给用户确认留一点时间后再试。
        if (attempt < 2) {
          await Future<void>.delayed(Duration(milliseconds: 800 * (attempt + 1)));
        }
      }
    }

    return false;
  }
}
