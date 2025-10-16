

import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/app/utils/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:async';
import '../config/app_config.dart';
import 'package:get/get.dart' as getutil;

class ServiceRequest {
  static Future get(
    String url, {
    Map<String, dynamic>? header,
    required Map<String, dynamic>? data,
    required Function? success,
    required Function? error,
    bool showProgress = true,

    ///需要单独处理的code
    List? excludeCode,
  }) async {
    Map<String, dynamic> headers = header ?? {};
    // 发送get请求
    await _sendRequest(
      url,
      'get',
      success!,
      data: data!,
      headers: headers,
      error: error!,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  static Future post(
    String url, {
    Map<String, dynamic>? header,
    required Map<String, dynamic>? data,
    required Function? success,
    required Function? error,
    bool showProgress = true,

    ///需要单独处理的code
    List? excludeCode,
  }) async {
    // 发送post请求
    Map<String, dynamic> headers = header ?? {};

    return _sendRequest(
      url,
      'post',
      success!,
      data: data!,
      headers: headers,
      error: error!,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  static Future put(
    String url, {
    Map<String, dynamic>? header,
    required Map<String, dynamic>? data,
    required Function? success,
    required Function? error,
    bool showProgress = true,

    ///需要单独处理的code
    List? excludeCode,
  }) async {
    // 发送post请求
    Map<String, dynamic> headers = header ?? {};
    return _sendRequest(
      url,
      'put',
      success!,
      data: data!,
      headers: headers,
      error: error!,
      showProgress: showProgress,
      excludeCode: excludeCode,
    );
  }

  ///上传文件
  static Future upload(
    String url, {
    Map<String, dynamic>? header,
    required Map<String, dynamic>? data,
    required Function? success,
    required Function? error,
    bool showProgress = true,

    ///需要单独处理的code
    List? excludeCode,
  }) async {
    // 发送post请求
    Map<String, dynamic> headers = header ?? {};
    return _sendRequest(
      url, 'upload', success!,
      data: data!,
      headers: headers,
      error: error!,
      showProgress: showProgress,

      ///需要单独处理的code
      excludeCode: excludeCode,
    );
  }

  // 请求处理
  static Future _sendRequest(
    String url,
    String method,
    Function success, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Function? error,
    bool? showProgress,

    ///需要单独处理的code
    List? excludeCode,
  }) async {
    int _code;
    String _msg;
    if (showProgress != null && showProgress) {
      SmartDialog.showLoading();
    }

    try {
      Map<String, dynamic> dataMap = data ?? {};

      Map<String, dynamic> headersMap = headers ?? {};

      //请求参数添加token
      if (isLogin) {
        dataMap.addAll({
          'token': getbox.read('token'),
        });
      }

      // headersMap.addAll({
      //   'platform': Platform.isIOS ? 'ios' : 'android',
      // });26869ac2-1cd1-45da-b659-de461d57633b

      // 配置dio请求信息
      Response? response;
      Dio dio = Dio();
      dio.options.validateStatus = (status) {
        return status! < 600;
      };
      dio.options.connectTimeout =
          const Duration(milliseconds: 60000); // 服务器链接超时，毫秒
      dio.options.receiveTimeout =
          const Duration(milliseconds: 60000); // 响应流上前后两次接受到数据的间隔，毫秒
      dio.options.contentType = Headers.formUrlEncodedContentType;
      dio.options.headers
          .addAll(headersMap); // 添加headers,如需设置统一的headers信息也可在此添加

      String baseurl = AppConfig.baseUrl;

      url = baseurl + url;

      if (method == 'get') {
        response = await dio.get(url, queryParameters: dataMap);
      } else if (method == 'post') {
        response = await dio.post(url, data: dataMap);
      } else if (method == 'put') {
        response = await dio.put(url, data: dataMap);
      } else if (method == 'upload') {
        dio.options.contentType = "application/x-www-form-urlencoded";
        FormData formData = FormData.fromMap(dataMap);
        response = await dio.post(url, data: formData);
      }
      SmartDialog.dismiss(status: SmartStatus.loading);

      Log.i(
          '$method请求\n url：$url\n 请求header： ${dio.options.headers}\n 请求参数： $dataMap\n 状态码: ${response!.statusCode}\n 返回值：${response.data}');

      Map<String, dynamic> resCallbackMap = response.data;

      ///先判断401
      if (response.statusCode == 401 &&
          excludeCode != null &&
          excludeCode.contains(401)) {
        success(resCallbackMap);
        return;
      }

      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          getbox.remove('token');
          if (getutil.Get.currentRoute != '/Login') {
            //TODO: 401 重新登录
            // getutil.Get.offAll(const Login());
          }
          return;
        }
        _msg = '网络请求错误\n${'状态码'}${response.statusCode}\nurl：$url';
        showToast(_msg);

        _handError(error!, _msg);
        return;
      }

      _code = resCallbackMap['result'];

      _msg = resCallbackMap['info'];

      //401 重新登录
      if (_code.toInt() == 2) {
        getbox.remove('token');
        if (getutil.Get.currentRoute != '/Login') {
          //TODO: 401 重新登录
          // getutil.Get.offAll(const Login());
        }

        return;
      }

      if (_code.toInt() != 1 &&
          (excludeCode == null || !excludeCode.contains(_code.toInt()))) {
        showToast(_msg);
        _handError(error!, _msg);

        return;
      }
      success(resCallbackMap);
    } catch (exception) {
      SmartDialog.dismiss(status: SmartStatus.loading);

      showToast('接口异常');
      _handError(error!, '$exception');
      Log.e('$url-----请求出错了-----\n$exception');
    }
  }

  // 返回错误信息
  // ignore: body_might_complete_normally_nullable
  static Future? _handError(Function errorCallback, String errorMsg) {
    errorCallback(errorMsg);
  }

  ///下载
  static Future<String> downloadImage(url, localFile) async {
    Dio dio = Dio();
    String path = localFile;
    await dio.download(url, path);
    return path;
  }
}
