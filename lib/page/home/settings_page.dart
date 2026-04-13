import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_config.dart';
import '../../app/controller/theme_controller.dart';
import '../../app/core/storage/storage_service.dart';
import '../../app/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _logout() async {
    await StorageService.clearToken();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = ThemeController.to;
    final Set<ThemeMode> selection = <ThemeMode>{themeController.themeMode};
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          const ListTile(
            title: Text('主题模式'),
            subtitle: Text('模板内置了浅色 / 深色 / 跟随系统三种模式'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<ThemeMode>(
              segments: const <ButtonSegment<ThemeMode>>[
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('浅色'),
                  icon: Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('深色'),
                  icon: Icon(Icons.dark_mode_outlined),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('系统'),
                  icon: Icon(Icons.settings_suggest_outlined),
                ),
              ],
              selected: selection,
              onSelectionChanged: (value) {
                themeController.setThemeMode(value.first);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('当前环境'),
            subtitle: Text('${AppConfig.current.label} (${AppConfig.envName})'),
          ),
          ListTile(
            title: const Text('BaseUrl'),
            subtitle: Text(AppConfig.baseUrl.isEmpty ? '未配置' : AppConfig.baseUrl),
          ),
          const Divider(),
          ListTile(
            title: const Text('退出登录'),
            subtitle: const Text('清理 token 并返回登录页'),
            trailing: const Icon(Icons.logout_rounded),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
