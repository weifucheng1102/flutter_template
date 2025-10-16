/*
 * @Author: 魏
 * @Date: 2025-09-04 11:59:39
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-09-04 11:59:42
 * @FilePath: /express_box/lib/app/utils/phone_util.dart
 * @Description: 手机号脱敏工具类
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

class PhoneUtils {
  /// 保留前3位和后4位，中间用 ****
  static String maskPhone(String phone) {
    if (phone.length < 7) return phone; // 长度不够不脱敏
    return "${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}";
  }

  /// 只保留后4位
  static String last4(String phone) {
    if (phone.length <= 4) return phone;
    return phone.substring(phone.length - 4);
  }

  /// 保留前n位和后m位，中间用 *
  static String maskCustom(String phone, {int front = 3, int back = 4}) {
    if (phone.length <= front + back) return phone;
    String stars = "*" * (phone.length - front - back);
    return phone.substring(0, front) +
        stars +
        phone.substring(phone.length - back);
  }
}
