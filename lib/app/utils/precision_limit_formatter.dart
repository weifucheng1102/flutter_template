/*
 * @Author: 魏
 * @Date: 2025-09-05 17:52:15
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-10-16 09:12:48
 * @FilePath: /flutter_template/lib/app/utils/precision_limit_formatter.dart
 * @Description:  输入框精度限制格式化器
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'package:flutter/services.dart';
import 'dart:math' as math;

class PrecisionLimitFormatter extends TextInputFormatter {
  int _scale;

  PrecisionLimitFormatter(this._scale);

  RegExp exp = RegExp(r"[0-9]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";
  static const String ZERO = "0";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // print('oldValue:${oldValue.text}');
    // print('newValue:${newValue.text}');
    if (newValue.text.startsWith('.')) {
      return const TextEditingValue(
        text: '0.',
        selection: TextSelection.collapsed(
          offset: 2,
        ),
      );
    }

    // if (newValue.text.startsWith(POINTER) && newValue.text.length == 1) {
    //   //第一个不能输入小数点
    //   return oldValue;
    // }

    ///输入完全删除
    if (newValue.text.isEmpty) {
      return const TextEditingValue();
    }

    ///只允许输入小数
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    if (newValue.text.startsWith(ZERO) &&
        newValue.text.split("0")[1].startsWith(RegExp(r'[0-9]'))) {
      return const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(
          offset: 1,
        ),
      );

      // return newValue;
    }

    ///包含小数点的情况
    if (newValue.text.contains(POINTER)) {
      ///包含多个小数
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      ///小数点后位数
      int lengthAfterPointer = input.substring(index, input.length).length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      ///不包含小数点,不能以“00”开头
      return oldValue;
    }
    return newValue;
  }
}
