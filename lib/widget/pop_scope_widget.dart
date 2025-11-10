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
import 'dart:io';

import 'package:flutter/material.dart';
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
    return PopScope(
      canPop: widget.canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _flag ^= 1;
          showToast('再次返回退出');
          Future.delayed(const Duration(seconds: 2), () => _flag = 0);
          if (_flag == 0) {
            exit(0);
          }
        }
      },
      child: widget.child,
    );
  }
}
