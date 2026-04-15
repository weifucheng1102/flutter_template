/*
 * @Author: 魏
 * @Date: 2025-08-26 14:01:32
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-08-27 17:13:02
 * @FilePath: /express_box/lib/app/widget/pop_scope_widget.dart
 * @Description: 返回手势退出
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

class PopScopeWidget extends StatefulWidget {
  final Widget child;
  final bool canPop;
  const PopScopeWidget({
    super.key,
    required this.child,
    this.canPop = false,
  });

  @override
  State<PopScopeWidget> createState() => _PopScopeWidgetState();
}

class _PopScopeWidgetState extends State<PopScopeWidget> {
  int _flag = 0;

  @override
  Widget build(BuildContext context) {
    // 双击返回退出只在 Android 主壳页场景下保留，避免影响 iOS 和其他平台体验。
    final bool enableExitOnBack =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (!enableExitOnBack) {
      return widget.child;
    }

    return PopScope(
      canPop: widget.canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _flag ^= 1;
          showToast('再次返回退出');
          Future.delayed(const Duration(seconds: 2), () => _flag = 0);
          if (_flag == 0) {
            SystemNavigator.pop();
          }
        }
      },
      child: widget.child,
    );
  }
}
