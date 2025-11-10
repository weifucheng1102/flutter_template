/*
 * @Author: 魏
 * @Date: 2025-09-13 10:59:17
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 09:12:58
 * @FilePath: /flutter_template/lib/app/config/brn_theme_config.dart
 * @Description: 全局配置bruno 主题
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

import 'app_config.dart';

class BrnConfigUtils {
  static BrnAllThemeConfig defaultAllConfig = BrnAllThemeConfig(
    commonConfig: defaultCommonConfig,
    appBarConfig: BrnAppBarConfig(
      leadIconBuilder: () {
        return BrnBackLeading(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        );
      },
      titleStyle: BrnTextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  static BrnCommonConfig defaultCommonConfig =
      BrnCommonConfig(brandPrimary: AppConfig.mainColor);
}
