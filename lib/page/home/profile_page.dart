import 'package:flutter/material.dart';

import '../../app/core/storage/storage_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('受保护页面')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user_outlined, size: 48),
              const SizedBox(height: 12),
              const Text('这个页面挂了登录中间件，未登录无法直接进入。'),
              const SizedBox(height: 8),
              Text('当前 token: ${StorageService.token ?? '无'}'),
            ],
          ),
        ),
      ),
    );
  }
}
