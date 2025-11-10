/*
 * @Author: 魏
 * @Date: 2025-09-04 10:00:27
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 10:02:24
 * @FilePath: /flutter_template/lib/widget/custom_button.dart
 * @Description: 自定义按钮
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/config/app_config.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final dynamic title;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final FontWeight fontWeight;
  final void Function()? onTap;
  final double? borderRadius;
  final double? font;
  final Gradient? gradient;
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.title = '确定',
    this.onTap,
    this.bgColor = AppConfig.mainColor,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w500,
    this.borderRadius,
    this.font,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: height ?? 98.w,
        width: width ?? 670.w,
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius:
                BorderRadius.circular(borderRadius ?? ((height ?? 98.w) / 2)),
            color: bgColor,
            border: Border.all(color: borderColor, width: 1.w)),
        alignment: Alignment.center,
        child: title.runtimeType == String
            ? Text(
                title,
                style: TextStyle(
                  fontSize: font ?? 26.sp,
                  fontWeight: fontWeight,
                  color: textColor,
                ),
              )
            : title,
      ),
    );
  }
}
