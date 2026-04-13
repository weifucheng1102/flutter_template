import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/storage/storage_service.dart';
import 'app_routes.dart';

class AuthGuardMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 这里保留最小登录守卫示例，后续项目可扩展为权限码、角色或租户校验。
    if (StorageService.hasToken) {
      return null;
    }
    return const RouteSettings(name: AppRoutes.login);
  }
}
