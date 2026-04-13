import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/core/storage/storage_service.dart';
import '../../app/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 模板默认保留一个 mock token 输入框，便于新项目还没接接口时先走通流程。
  final TextEditingController _tokenController = TextEditingController(
    text: 'mock-token',
  );

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String token = _tokenController.text.trim();
    if (token.isEmpty) {
      Get.snackbar('提示', '请输入 token 或替换成真实登录接口');
      return;
    }
    await StorageService.saveToken(token);
    if (!mounted) {
      return;
    }
    Get.offAllNamed(AppRoutes.launch);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('登录页模板')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('建议直接替换为真实登录流程', style: textTheme.headlineSmall),
            const SizedBox(height: 12),
            const Text('这个页面的意义是保留模板工程的登录路由、登录态存储和跳转链路。'),
            const SizedBox(height: 24),
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: '登录 token',
                hintText: '开发期可先用 mock token',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _login,
              child: const Text('模拟登录'),
            ),
          ],
        ),
      ),
    );
  }
}
