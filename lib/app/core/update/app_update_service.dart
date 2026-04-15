import 'dart:async';

import '../../utils/logger.dart';

class AppUpdateService {
  AppUpdateService._();

  static DateTime? _lastCheckTime;

  /// 模板默认的更新检测入口。
  ///
  /// 当前只保留能力骨架，不直接绑定具体接口。
  /// 新项目接入时，建议在这里统一接版本接口、强更弹窗和下载跳转。
  static Future<void> checkForUpdates({
    bool force = false,
    Duration throttle = const Duration(minutes: 30),
  }) async {
    if (!force &&
        _lastCheckTime != null &&
        DateTime.now().difference(_lastCheckTime!) < throttle) {
      return;
    }

    _lastCheckTime = DateTime.now();
    Log.i('执行模板更新检测，当前为占位实现，请替换为真实版本接口');

    // 示例接入点：
    // 1. 读取当前 app 版本
    // 2. 请求后端版本接口
    // 3. 判断是否需要强更/非强更
    // 4. 弹窗提示并跳转下载链接
  }
}
