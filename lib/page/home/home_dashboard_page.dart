import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_config.dart';
import '../../app/core/storage/storage_service.dart';
import '../../app/routes/app_routes.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isLoggedIn = StorageService.hasToken;
    return Scaffold(
      appBar: AppBar(
        title: const Text('项目骨架'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('模板状态', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('环境: ${AppConfig.current.label} (${AppConfig.envName})'),
                    Text('BaseUrl: ${AppConfig.baseUrl.isEmpty ? '未配置' : AppConfig.baseUrl}'),
                    Text('登录态: ${isLoggedIn ? '已登录' : '未登录'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('推荐起步动作', style: textTheme.titleMedium),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.login_rounded,
              title: isLoggedIn ? '重新登录' : '去登录',
              subtitle: '替换成真实账号体系前，可先用模板登录页走通链路',
              onTap: () => Get.toNamed(AppRoutes.login),
            ),
            _ActionTile(
              icon: Icons.person_outline_rounded,
              title: '受保护页面',
              subtitle: '这个路由挂了登录中间件，未登录会自动跳去登录页',
              onTap: () => Get.toNamed(AppRoutes.profile),
            ),
            _ActionTile(
              icon: Icons.color_lens_outlined,
              title: '主题演示页',
              subtitle: '查看当前主题色和组件基线是否符合项目设计',
              onTap: () => Get.toNamed(AppRoutes.themeDemo),
            ),
            _ActionTile(
              icon: Icons.settings_outlined,
              title: '设置页',
              subtitle: '演示主题切换、退出登录和环境信息展示',
              onTap: () => Get.toNamed(AppRoutes.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
