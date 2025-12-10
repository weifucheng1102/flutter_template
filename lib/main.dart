/*
 * @Author: 魏
 * @Date: 2025-08-26 15:51:12
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-12-10 09:45:45
 * @FilePath: /flutter_template/lib/main.dart
 * @Description: 主入口
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

import 'app/config/app_config.dart';
import 'app/config/brn_theme_config.dart';
import 'page/launch/agreement_notice.dart';
import 'page/launch/launch_page.dart';

void main() async {
  //brn 配置
  BrnInitializer.register(allThemeConfig: BrnConfigUtils.defaultAllConfig);
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1440),
      builder: (context, child) {
        return OKToast(
          child: GetMaterialApp(
            title: '',

            ///右上角debug角标
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //页面背景色
              scaffoldBackgroundColor: AppConfig.backgroundColor,
              tabBarTheme: const TabBarTheme(dividerHeight: 0.0),
              appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
              useMaterial3: true,
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              BrnLocalizationDelegate.delegate,
            ],
            //默认语言
            locale: const Locale('zh'),
            //支持的语言，后期根据需要添加
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('zh', 'CN'),
            ],
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.noScaling,
                  ),
                  child: KeyboardDismissOnTap(child: child!),
                );
              },
            ),
            home: isFirst ? const AgreementNotice() : const LaunchPage(),
          ),
        );
      },
    );
  }
}
