/*
 * @Author: 魏
 * @Date: 2025-08-27 16:44:30
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 10:39:00
 * @FilePath: /flutter_template/lib/page/launch/navigate_page.dart
 * @Description: 导航页
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../home/home_dashboard_page.dart';
import '../home/settings_page.dart';
import '../demo/theme_color_demo_page.dart';
import '../../widget/pop_scope_widget.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage({super.key});

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  int _currentIndex = 0;

  // 底部导航默认只放 3 个稳定入口，方便模板项目快速替换成真实模块。
  static const List<Widget> _pages = <Widget>[
    HomeDashboardPage(),
    ThemeColorDemoPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScopeWidget(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: '工作台',
            ),
            NavigationDestination(
              icon: Icon(Icons.color_lens_outlined),
              selectedIcon: Icon(Icons.color_lens_rounded),
              label: '主题',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings_rounded),
              label: '设置',
            ),
          ],
        ),
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () => Get.toNamed(AppRoutes.profile),
                icon: const Icon(Icons.person_outline_rounded),
                label: const Text('受保护路由'),
              )
            : null,
      ),
    );
  }
}
