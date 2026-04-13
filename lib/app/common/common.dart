/*
 * @Author: 魏
 * @Date: 2025-08-27 17:10:23
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2026-02-24 14:02:18
 * @FilePath: /flutter_template/lib/app/common/common.dart
 * @Description: 
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_dialog.dart';
import '../config/app_theme.dart';
import '../core/storage/storage_service.dart';
import '../utils/logger.dart';

///操作 成功弹窗
void showSuccessDialog(String msg, VoidCallback callback) {
  SmartDialog.show(
    displayTime: const Duration(seconds: 1),
    builder: (context) {
      return Container(
        height: 300.w,
        width: 300.w,
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 100.w,
            ),
            SizedBox(
              height: 20.w,
            ),
            Text(
              msg,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),
      );
    },
    alignment: Alignment.center,
    onDismiss: () {
      callback.call();
    },
  );
}

Future<bool> requestPermission(Permission permission, String descText) async {
  final bool isChecking = StorageService.isChecking;

  PermissionStatus status = await permission.status;
  Log.i('获取权限状态: $permission, status: $status');
  if (status == PermissionStatus.granted) {
    return true;
  }

  if (status == PermissionStatus.permanentlyDenied) {
    Log.w('权限已被永久拒绝: $permission');
    return false;
  }

  if (status == PermissionStatus.denied ||
      status == PermissionStatus.limited) {
    if (isChecking && Platform.isAndroid) {
      final List<dynamic> permissionList =
          StorageService.permissionList;
      final bool hasRequested = permissionList.contains(permission.value);
      if (hasRequested) {
        return false;
      }

      if (Get.context == null) {
        Log.w('权限提醒弹窗缺少 context，跳过弹窗后直接请求权限');
      } else {
        await Get.dialog<void>(
          PopScope(
            canPop: false,
            child: BrnDialog(
              titleText: '权限提醒',
              messageText: descText,
              actionsText: const ['知道了'],
              indexedActionCallback: (index) {
                Get.back();
              },
            ),
          ),
          barrierDismissible: false,
        );
      }

      status = await permission.request();
      await StorageService.savePermissionList(
        <dynamic>[...permissionList, permission.value],
      );
      Log.i('审核模式权限请求结果: $permission, status: $status');
      return status == PermissionStatus.granted;
    }

    status = await permission.request();
    Log.i('权限请求结果: $permission, status: $status');
    return status == PermissionStatus.granted;
  }

  return false;
}

///更新上传图片
Future<void> uploadImage({
  ///上传类型 1：用户头像 0:其他
  required int type,
  required String imagePath,
  required void Function(String imgUrl, String shortUrl) callback,
}) async {
  Log.w('uploadImage 未实现, type: $type, imagePath: $imagePath');
  SmartDialog.showToast('请先实现图片上传接口');
}

///
///操作询问弹窗
Future<void> showSubmitDialog({
  String? title,
  String? msg,
  List<TextEditingController>? textfieldList,
  List<String>? fieldHintTextList,
  Widget? bottomWidget,
  VoidCallback? callback,
  bool barrierDismissible = true,
  bool autoFocus = true,
}) {
  final BuildContext? context = Get.context;
  if (context == null) {
    Log.w('showSubmitDialog 调用时缺少 context');
    return Future<void>.value();
  }

  final AppColorScheme colors =
      Theme.of(context).extension<AppColorScheme>() ?? AppTheme.lightColors;
  final List<Widget> textFieldViewList = <Widget>[];
  final List<String> resolvedHintTextList;
  if (textfieldList == null) {
    resolvedHintTextList = const <String>[];
  } else if (fieldHintTextList == null) {
    resolvedHintTextList = List<String>.filled(textfieldList.length, '请输入');
  } else {
    resolvedHintTextList = <String>[
      ...fieldHintTextList,
      ...List<String>.filled(
        textfieldList.length - fieldHintTextList.length,
        '请输入',
      ),
    ];
  }

  if (textfieldList != null) {
    for (int i = 0; i < textfieldList.length; i++) {
      textFieldViewList.add(
        Padding(
          padding: EdgeInsets.only(top: 32.w),
          child: Container(
            height: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.w),
              color: colors.backgroundColor,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: TextField(
              controller: textfieldList[i],
              autofocus: i == 0 ? autoFocus : false,
              decoration: InputDecoration(
                hintText: resolvedHintTextList[i],
                hintStyle: TextStyle(
                  color: const Color(0xffb5bcc8),
                  fontSize: 28.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      );
    }
  }

  return CustomDialog.showCustomDialog(
    context,
    barrierDismissible: barrierDismissible,
    child: Container(
      width: 560.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
      child: Column(
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 34.sp,
                  color: const Color(0xff131519),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (msg != null)
            Padding(
              padding: EdgeInsets.only(top: 32.w),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xffb5bcc8),
                ),
              ),
            ),
          ...textFieldViewList,
          if (bottomWidget != null)
            Padding(
              padding: EdgeInsets.only(top: 32.w),
              child: bottomWidget,
            ),
          Padding(
            padding: EdgeInsets.only(top: 48.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  height: 80.w,
                  width: 224.w,
                  title: '取消',
                  bgColor: const Color(0xfff4f6f7),
                  textColor: const Color(0xff5f626a),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 32.w,
                ),
                CustomButton(
                  height: 80.w,
                  width: 224.w,
                  title: '确定',
                  onTap: () {
                    if (callback != null) {
                      callback.call();
                    } else {
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
