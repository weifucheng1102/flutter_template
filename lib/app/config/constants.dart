import 'package:flutter_screenutil/flutter_screenutil.dart';

/// constants.dart
/// 存放全局常量

class Constants {
  // ================== 存储 Key ==================
  static const String xxx = "xxx";

  // ================== 正则表达式 ==================
  static const String regexEmail =
      r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
  static const String regexPhone = r"^1[3-9]\d{9}$";

  // ================== 页面通用参数 ==================
  //页数
  static const int pageSize = 20;
  static double defaultPadding = 30.w;
}
