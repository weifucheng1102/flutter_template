/*
 * @Author: 魏
 * @Date: 2025-08-26 15:22:53
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 10:30:41
 * @FilePath: /flutter_template/lib/app/config/app_config.dart
 * @Description: 全局配置文件
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

enum AppEnvironment {
  dev,
  test,
  prod;

  static AppEnvironment fromName(String value) {
    switch (value.toLowerCase()) {
      case 'prod':
        return AppEnvironment.prod;
      case 'test':
        return AppEnvironment.test;
      case 'dev':
      default:
        return AppEnvironment.dev;
    }
  }
}

class AppEnvConfig {
  const AppEnvConfig({
    required this.label,
    required this.baseUrl,
    required this.networkWarmupUrl,
    required this.wechatPayAppid,
    required this.wechatPayIosUniversalLink,
  });

  final String label;
  final String baseUrl;
  final String networkWarmupUrl;
  final String wechatPayAppid;
  final String wechatPayIosUniversalLink;
}

class AppConfig {
  static const String _envName =
      String.fromEnvironment('APP_ENV', defaultValue: 'dev');

  static final AppEnvironment env = AppEnvironment.fromName(_envName);

  static const AppEnvConfig _devConfig = AppEnvConfig(
    label: '开发',
    baseUrl: '',
    networkWarmupUrl: 'https://www.baidu.com',
    wechatPayAppid: 'xxxxxxxxx',
    wechatPayIosUniversalLink: 'https://wwwwwww.com/iosApp/',
  );

  static const AppEnvConfig _testConfig = AppEnvConfig(
    label: '测试',
    baseUrl: '',
    networkWarmupUrl: 'https://www.baidu.com',
    wechatPayAppid: 'xxxxxxxxx',
    wechatPayIosUniversalLink: 'https://wwwwwww.com/iosApp/',
  );

  static const AppEnvConfig _prodConfig = AppEnvConfig(
    label: '生产',
    baseUrl: '',
    networkWarmupUrl: 'https://www.baidu.com',
    wechatPayAppid: 'xxxxxxxxx',
    wechatPayIosUniversalLink: 'https://wwwwwww.com/iosApp/',
  );

  static AppEnvConfig get current {
    switch (env) {
      case AppEnvironment.test:
        return _testConfig;
      case AppEnvironment.prod:
        return _prodConfig;
      case AppEnvironment.dev:
        return _devConfig;
    }
  }

  static String get envName => env.name;

  static bool get isProd => env == AppEnvironment.prod;

  static bool get hasBaseUrl => current.baseUrl.trim().isNotEmpty;

  /// api地址
  static String get baseUrl => current.baseUrl;

  /// iOS 首次网络访问预热地址。
  ///
  /// 模板默认保留百度作为兜底示例，建议尽快替换成你自己的轻量接口。
  static String get networkWarmupUrl => current.networkWarmupUrl;

  /// 微信支付配置
  static String get wechatPayAppid => current.wechatPayAppid;

  static String get wechatPayIosUniversalLink =>
      current.wechatPayIosUniversalLink;
}
