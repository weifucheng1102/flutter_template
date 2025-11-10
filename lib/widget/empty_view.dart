/*
 * @Author: 魏
 * @Date: 2025-02-19 14:18:45
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-09-02 09:51:41
 * @FilePath: /express_box/lib/app/widget/empty_view.dart
 * @Description: 空视图
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  final String? content;
  const EmptyView({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return BrnAbnormalStateWidget(
      img: Image.asset(
        'images/empty.png',
        width: 500.w,
      ),
      bgColor: Colors.transparent,
      content: content ?? '暂无数据',
    );
  }
}
