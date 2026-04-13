import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LegalDocumentArgs {
  const LegalDocumentArgs({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
}

class LegalDocumentPage extends StatelessWidget {
  const LegalDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LegalDocumentArgs? args =
        Get.arguments is LegalDocumentArgs ? Get.arguments as LegalDocumentArgs : null;
    final String title = args?.title ?? '文档';
    final String content = args?.content ?? '请替换成真实协议内容。';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
