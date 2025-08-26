import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

import 'modules/my_home_page.dart';

void main() async {
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
            ///右上角debug角标
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //页面背景色
              scaffoldBackgroundColor: Colors.white,
              tabBarTheme: const TabBarTheme(dividerHeight: 0.0),
              appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
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
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        );
      },
    );
  }
}
