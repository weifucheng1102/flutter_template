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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/config/app_config.dart';
import '../../app/utils/logger.dart';
import '../../widget/pop_scope_widget.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage({super.key});

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PopScopeWidget(
      child: Scaffold(
        // #TOTO 根据实际情况是否添加NavigationBar

        // bottomNavigationBar: Container(
        //   color: Colors.white,
        //   child: SafeArea(
        //     child: BottomAppBar(
        //       color: Colors.white,
        //       height: 100.w,
        //       padding: EdgeInsets.zero,
        //       shape: const CircularNotchedRectangle(),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           _buildTabItem(
        //             index: 0,
        //             icon: 'images/tab0-.png',
        //             selIcon: 'images/tab0.png',
        //             label: '首页',
        //           ),
        //           _buildTabItem(
        //             index: 1,
        //             icon: 'images/tab1-.png',
        //             selIcon: 'images/tab1.png',
        //             label: '我的派件',
        //           ),
        //           _buildTabItem(
        //             index: 2,
        //             icon: 'images/tab2-.png',
        //             selIcon: 'images/tab2.png',
        //             label: '我的',
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // body: IndexedStack(
        //   index: _currentIndex,
        //   children: getPage(),
        // ),
        // body: getPage()[_currentIndex],
        body: Container(),
      ),
    );
  }

  void onTabSelected(int index) {
    Log.i('点击了$index');
    if (index == _currentIndex) return; // 如果点击的是当前选中的tab，则不做任何操作
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      default:
        break;
    }
  }

  List<Widget> getPage() {
    // #TODO 这里需要根据实际情况来添加页面
    return [
      // HomeIndex(
      //   onGoToDelivery: () {
      //     setState(() {
      //       _currentIndex = 1;
      //     });
      //   },
      // ),
      // const DeliveryIndex(),
      // const MineIndex(),
    ];
  }

  Widget _buildTabItem({
    required int index,
    required String icon,
    required String selIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppConfig.mainColor : AppConfig.textMainColor;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTabSelected(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(isSelected ? selIcon : icon, width: 42.w),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 22.w),
            ),
          ],
        ),
      ),
    );
  }
}
