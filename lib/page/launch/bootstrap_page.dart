import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/core/network/network_warmup_service.dart';
import '../../app/core/storage/storage_service.dart';
import '../../app/routes/app_routes.dart';

class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _prepareNetworkWarmup();
      _routeNext();
    });
  }

  Future<void> _prepareNetworkWarmup() async {
    // 只有用户已同意协议时，才允许触发网络预热，避免在隐私同意前发请求。
    if (!StorageService.hasAcceptedAgreement) {
      return;
    }
    await NetworkWarmupService.ensureReady();
  }

  void _routeNext() {
    // 启动分流只做最小判断：协议确认 -> 登录态 -> 首页。
    if (!StorageService.hasAcceptedAgreement) {
      Get.offAllNamed(AppRoutes.agreement);
      return;
    }

    if (StorageService.hasToken) {
      Get.offAllNamed(AppRoutes.launch);
      return;
    }

    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
