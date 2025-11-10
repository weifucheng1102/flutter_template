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

import 'navigate_page.dart';
import 'page_config.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const PageConfig(
      child: NavigatePage(),
    );
  }
}
