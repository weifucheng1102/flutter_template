import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart' as getutil;
import 'package:oktoast/oktoast.dart';

import '../config/app_config.dart';
import '../core/network/network_warmup_service.dart';
import '../core/storage/storage_keys.dart';
import '../core/storage/storage_service.dart';
import 'logger.dart';

typedef ServiceSuccess = void Function(Map<String, dynamic> response);
typedef ServiceError = void Function(String message);

class ServiceRequest {
  ServiceRequest._();

  static final Dio _dio = _createDio();

  static Future get(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? data,
    required ServiceSuccess success,
    required ServiceError error,
    bool showProgress = true,

    ///需要单独处理的code
    List<int>? excludeCode,
  }) async {
    await _sendRequest(
      url,
      'get',
      success,
      data: data,
      headers: header,
      error: error,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  static Future post(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? data,
    required ServiceSuccess success,
    required ServiceError error,
    bool showProgress = true,

    ///需要单独处理的code
    List<int>? excludeCode,
  }) async {
    return _sendRequest(
      url,
      'post',
      success,
      data: data,
      headers: header,
      error: error,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  static Future put(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? data,
    required ServiceSuccess success,
    required ServiceError error,
    bool showProgress = true,

    ///需要单独处理的code
    List<int>? excludeCode,
  }) async {
    return _sendRequest(
      url,
      'put',
      success,
      data: data,
      headers: header,
      error: error,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  ///上传文件
  static Future upload(
    String url, {
    Map<String, dynamic>? header,
    Map<String, dynamic>? data,
    required ServiceSuccess success,
    required ServiceError error,
    bool showProgress = true,

    ///需要单独处理的code
    List<int>? excludeCode,
  }) async {
    return _sendRequest(
      url,
      'upload',
      success,
      data: data,
      headers: header,
      error: error,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  // 请求处理
  static Future _sendRequest(
    String url,
    String method,
    ServiceSuccess success, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    required ServiceError error,
    bool? showProgress,
    bool hasRetriedAfterWarmup = false,

    ///需要单独处理的code
    List<int>? excludeCode,
  }) async {
    if (showProgress != null && showProgress) {
      SmartDialog.showLoading();
    }

    try {
      if (!AppConfig.hasBaseUrl) {
        const String message = 'AppConfig.baseUrl 未配置';
        showToast(message);
        _handError(error, message);
        return;
      }

      final Map<String, dynamic> dataMap = _composeRequestData(data);
      final String requestUrl = '${AppConfig.baseUrl}$url';
      final Response<dynamic> response = await _request(
        requestUrl,
        method: method,
        data: dataMap,
        headers: headers,
      );
      SmartDialog.dismiss(status: SmartStatus.loading);

      Log.i(
        '$method请求\n url：$requestUrl\n 请求header： ${response.requestOptions.headers}\n 请求参数： $dataMap\n 状态码: ${response.statusCode}\n 返回值：${response.data}',
      );

      final dynamic rawData = response.data;
      if (rawData is! Map<String, dynamic>) {
        const String message = '接口返回数据格式异常';
        showToast(message);
        _handError(error, message);
        return;
      }
      final Map<String, dynamic> resCallbackMap = rawData;

      ///先判断401
      if (response.statusCode == 401 &&
          excludeCode != null &&
          excludeCode.contains(401)) {
        success(resCallbackMap);
        return;
      }

      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          await StorageService.clearToken();
          if (getutil.Get.currentRoute != '/Login') {
            //TODO: 401 重新登录
            // getutil.Get.offAll(const Login());
          }
          return;
        }
        final String message =
            '网络请求错误\n状态码${response.statusCode}\nurl：$requestUrl';
        showToast(message);

        _handError(error, message);
        return;
      }

      final int code = _readInt(resCallbackMap['result']);
      final String message = (resCallbackMap['info'] ?? '').toString();

      //401 重新登录
      if (code == 2) {
        await StorageService.clearToken();
        if (getutil.Get.currentRoute != '/Login') {
          //TODO: 401 重新登录
          // getutil.Get.offAll(const Login());
        }

        return;
      }

      if (code != 1 && (excludeCode == null || !excludeCode.contains(code))) {
        showToast(message);
        _handError(error, message);

        return;
      }
      success(resCallbackMap);
    } catch (exception) {
      if (!hasRetriedAfterWarmup &&
          await _shouldRetryAfterWarmup(exception)) {
        final bool isReady = await NetworkWarmupService.ensureReady(force: true);
        if (isReady) {
          Log.i('网络预热完成，自动重试原请求: $url');
          return _sendRequest(
            url,
            method,
            success,
            data: data,
            headers: headers,
            error: error,
            showProgress: showProgress,
            hasRetriedAfterWarmup: true,
            excludeCode: excludeCode,
          );
        }
      }

      SmartDialog.dismiss(status: SmartStatus.loading);

      showToast('接口异常');
      _handError(error, '$exception');
      Log.e('$url-----请求出错了-----\n$exception');
    }
  }

  // 返回错误信息
  static void _handError(ServiceError errorCallback, String errorMsg) {
    errorCallback(errorMsg);
  }

  ///下载
  static Future<String> downloadImage(String url, String localFile) async {
    final String path = localFile;
    await _dio.download(url, path);
    return path;
  }

  static Dio _createDio() {
    final Dio dio = Dio();
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);
    dio.options.validateStatus = (status) => status != null && status < 600;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (!AppConfig.isProd) {
            Log.d('发起请求: ${options.method} ${options.uri}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (!AppConfig.isProd) {
            Log.d(
              '收到响应: ${response.requestOptions.method} ${response.requestOptions.uri} status=${response.statusCode}',
            );
          }
          handler.next(response);
        },
        onError: (error, handler) {
          Log.e(
            '请求异常: ${error.requestOptions.method} ${error.requestOptions.uri}\n$error',
          );
          handler.next(error);
        },
      ),
    );
    return dio;
  }

  static Future<Response<dynamic>> _request(
    String url, {
    required String method,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) {
    final bool isUpload = method == 'upload';
    // 统一在这里收口请求方式，避免业务层直接散落 dio.request 配置。
    final Options options = Options(
      method: isUpload ? 'POST' : method.toUpperCase(),
      contentType: isUpload
          ? Headers.multipartFormDataContentType
          : Headers.formUrlEncodedContentType,
      headers: <String, dynamic>{...?headers},
    );

    return _dio.request<dynamic>(
      url,
      data: isUpload || method != 'get'
          ? (isUpload ? FormData.fromMap(data) : data)
          : null,
      queryParameters: method == 'get' ? data : null,
      options: options,
    );
  }

  static Map<String, dynamic> _composeRequestData(
    Map<String, dynamic>? data,
  ) {
    final Map<String, dynamic> requestData = <String, dynamic>{...?data};
    if (StorageService.hasToken) {
      requestData[StorageKeys.token] = StorageService.token;
    }
    return requestData;
  }

  static int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? -1;
  }

  static Future<bool> _shouldRetryAfterWarmup(dynamic exception) async {
    if (!Platform.isIOS || !NetworkWarmupService.isEnabled) {
      return false;
    }

    if (exception is DioException) {
      return exception.type == DioExceptionType.connectionError ||
          exception.type == DioExceptionType.unknown ||
          exception.type == DioExceptionType.connectionTimeout;
    }

    return false;
  }
}
