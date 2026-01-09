/*
 * @Author: 魏
 * @Date: 2025-02-08 14:54:34
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2026-01-09 16:17:00
 * @FilePath: /flutter_template/lib/widget/scan_view.dart
 * @Description: 扫二维码
 *
 * Copyright (c) 2025 by 魏, All Rights Reserved.
 */
import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/app/config/app_config.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  /// ⭐ 扫描锁，防止多次回调
  bool _hasScanned = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '扫一扫'.tr,
      ),
      body: SafeArea(
        child: QRView(
          key: qrKey,
          overlay: QrScannerOverlayShape(
            borderColor: AppConfig.mainColor,
            borderRadius: 16.w,
            borderLength: 30.w,
            borderWidth: 10.w,
            cutOutSize: 0.7.sw,
          ),
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      // 🚫 已扫描过，直接拦截
      if (_hasScanned) return;

      _hasScanned = true;

      // ⏸ 暂停相机，防止继续识别
      await controller.pauseCamera();

      // 返回扫码结果
      Get.back(result: scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
