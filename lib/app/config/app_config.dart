/*
 * @Author: 魏
 * @Date: 2025-08-26 15:22:53
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 10:08:33
 * @FilePath: /flutter_template/lib/app/config/app_config.dart
 * @Description: 全局配置文件
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

/// app_config.dart
/// 全局配置文件

class AppConfig {
  /// api地址
  static const String baseUrl = '';

  ///颜色配置
  static const Color mainColor = Color(0xFF007AFF);
  static const Color backgroundColor = Color(0xFFF8F8F8);
  static const Color textMainColor = Color(0xFF333333);
  static const Color textSubColor = Color(0xFF999999);
  static const Color lineColor = Color(0xFFE4E4E4);

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
