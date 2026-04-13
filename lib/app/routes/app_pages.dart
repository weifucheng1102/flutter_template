import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/auth/login_page.dart';
import '../../page/home/profile_page.dart';
import '../../page/home/settings_page.dart';
import '../../page/launch/agreement_notice.dart';
import '../../page/launch/bootstrap_page.dart';
import '../../page/launch/launch_page.dart';
import '../../page/legal/legal_document_page.dart';
import '../routes/app_middlewares.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  /// 统一路由注册入口，模板项目后续直接在这里追加业务模块页面。
  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.bootstrap,
      page: () => const BootstrapPage(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.agreement,
      page: () => const AgreementNotice(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.launch,
      page: () => const LaunchPage(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      middlewares: <GetMiddleware>[AuthGuardMiddleware()],
    ),
    GetPage<dynamic>(
      name: AppRoutes.legal,
      page: () => const LegalDocumentPage(),
    ),
  ];

  static final GetPage<dynamic> unknownRoute = GetPage<dynamic>(
    name: AppRoutes.notFound,
    page: () => const _NotFoundPage(),
  );
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('页面不存在')),
      body: const Center(
        child: Text('404 - 请检查路由配置'),
      ),
    );
  }
}
