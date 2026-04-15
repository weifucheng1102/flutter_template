/*
 * @Author: 魏
 * @Date: 2025-06-19 17:16:40
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 09:55:48
 
 * @Description: 
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../app/core/update/app_update_service.dart';
import 'navigate_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAppUpdate(force: true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAppUpdate();
    }
  }

  Future<void> _checkAppUpdate({bool force = false}) async {
    // 主壳页负责承接登录后的初始化任务，更新检测挂这里比启动分流页更合适。
    await AppUpdateService.checkForUpdates(force: force);
  }

  @override
  Widget build(BuildContext context) {
    return const NavigatePage();
  }
}
