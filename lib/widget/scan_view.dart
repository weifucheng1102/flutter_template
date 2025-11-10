/*
 * @Author: 魏
 * @Date: 2025-02-08 14:54:34
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 10:11:08
 * @FilePath: /flutter_template/lib/widget/scan_view.dart
 * @Description: 扫二维码
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../app/config/app_config.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  // Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '扫一扫',
      ),
      body: SafeArea(
          child: QRView(
        key: qrKey,
        overlay: QrScannerOverlayShape(
            borderColor: AppConfig.mainColor,
            borderRadius: 16.w,
            borderLength: 30.w,
            borderWidth: 10.w,
            cutOutSize: 0.7.sw),
        onQRViewCreated: _onQRViewCreated,
      )),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.stopCamera();
      Get.back(result: scanData.code);
    });
  }
}
