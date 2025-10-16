import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

/// app_config.dart
/// 全局配置文件

class AppConfig {
  /// api地址
  static const String baseUrl = '';

  ///颜色配置
  static const Color mainColor = Color(0xFF007AFF);

  ///微信支付配置
  static const String wechatPayAppid = 'wxd4904bd7dc34a2b8';
  static const String wechatPayIosUniversalLink =
      'https://wxzf.sdzcwlkj.cn/iosApp/';
}

GetStorage getbox = GetStorage();
//第一次打开
bool get isFirst => getbox.read('isFirst') ?? true;

/// 登录状态
bool get isLogin => getbox.read('token') != null;
