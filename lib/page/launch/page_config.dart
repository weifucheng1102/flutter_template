/*
 * @Author: 魏
 * @Date: 2025-05-27 16:22:26
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 09:51:46
 * @FilePath: /flutter_template/lib/page/launch/page_config.dart
 * @Description: 页面配置
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'package:flutter/material.dart';

class PageConfig extends StatefulWidget {
  final Widget child;
  const PageConfig({super.key, required this.child});

  @override
  State<PageConfig> createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {
  @override
  void initState() {
    super.initState();
    getConfig();
    // if (Platform.isAndroid) {
    //   getUpdateRequest();
    // }
  }

  getConfig() {
    // ServiceRequest.post(
    //   '/app/kdgServiceConfig/details.json',
    //   data: {},
    //   success: (res) {
    //     getbox.write(
    //         'isHiddenPayment', res['kdgServiceConfig']['isHiddenPayment'] == 1);
    //   },
    //   error: (error) {},
    // );
  }

  // getUpdateRequest() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String buildNumber = packageInfo.buildNumber;
  //   ServiceRequest.post(
  //     '/api/order/app_version',
  //     data: {},
  //     showProgress: false,
  //     success: (res) {
  //       if (int.parse(buildNumber) < res['data']['app_version']) {
  //         showUpdateDialog(
  //           res['data']['is_force'],
  //           res['data']['app_download_url'],
  //           '有新内容更新了',
  //         );
  //       }
  //     },
  //     error: (error) {},
  //   );
  // }

  @override
  Widget build(BuildContext context) => widget.child;
}
