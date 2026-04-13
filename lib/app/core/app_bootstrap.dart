import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../config/brn_theme_config.dart';
import '../controller/theme_controller.dart';
import 'error/app_error_handler.dart';

class AppBootstrap {
  AppBootstrap._();

  /// 统一应用启动入口。
  ///
  /// 新项目后续如果要在启动阶段增加埋点、远程配置、崩溃上报初始化，
  /// 优先放在这里，不要继续把 main.dart 写成初始化大杂烩。
  static Future<void> run(Widget app) {
    return AppErrorHandler.run(() async {
      WidgetsFlutterBinding.ensureInitialized();
      AppErrorHandler.register();

      await GetStorage.init();
      Get.put(ThemeController());

      BrnInitializer.register(
        allThemeConfig:
            BrnConfigUtils.buildAllConfig(ThemeController.to.colors.mainColor),
      );

      runApp(app);
    });
  }
}
