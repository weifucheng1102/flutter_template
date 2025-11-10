/*
 * @Author: 魏
 * @Date: 2025-08-27 17:10:23
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-11-10 10:07:26
 * @FilePath: /flutter_template/lib/app/common/common.dart
 * @Description: 
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

import 'dart:io';
import 'dart:ui';

import 'package:bruno/bruno.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as dio;

import '../../widget/custom_button.dart';
import '../../widget/custom_dialog.dart';
import '../config/app_config.dart';

///操作 成功弹窗
showSuccessDialog(String msg, VoidCallback callback) {
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
  //判断是否是审核中
  bool isChecking = getbox.read('isChecking') ?? false;

  var status = await permission.status;
  print('获取权限状态$permission');
  if (status == PermissionStatus.granted) {
    print('权限已通过');

    ///已授权
    return true;
  } else if (status == PermissionStatus.permanentlyDenied) {
    print('权限已被永久拒绝');

    ///永久拒绝
    return false;
  } else if (status == PermissionStatus.denied) {
    ///安卓并且审核中  上架要求 判断申请一次 就拒绝了 之后就不再弹出
    if (isChecking && Platform.isAndroid) {
      List permissionList = getbox.read('permissionlist') ?? [];
      bool have = permissionList.contains(permission.value);
      if (have) {
        return false;
      }
      print('权限弹窗提醒');
      await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (ctx) => PopScope(
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
      );
      status = await permission.request();
      getbox.write('permissionlist', [...permissionList, permission.value]);
      print('请求权限');
      if (status == PermissionStatus.granted) {
        print('权限通过');
        return true;
      } else {
        print('权限拒绝');
        return false;
      }
    } else {
      status = await permission.request();
      print('请求权限');
      if (status == PermissionStatus.granted) {
        print('权限通过');
        return true;
      } else {
        print('权限拒绝');
        return false;
      }
    }

    // ///判断权限是否需要显示描述文本
    // bool isShowDesc = await permission.shouldShowRequestRationale;
    // if (isShowDesc) {
    //   await showDialog(
    //     barrierDismissible: false,
    //     context: Get.context!,
    //     builder: (ctx) => PopScope(
    //       canPop: false,
    //       child: BrnDialog(
    //         titleText: '权限提醒',
    //         messageText: descText,
    //         actionsText: const ['知道了'],
    //         indexedActionCallback: (index) {
    //           Get.back();
    //         },
    //       ),
    //     ),
    //   );
    // }

    // status = await permission.request();
    // print('请求权限');
    // if (status == PermissionStatus.granted) {
    //   print('权限通过');
    //   return true;
    // } else {
    //   print('权限拒绝');
    //   return false;
    // }
  } else {
    return false;
  }
}

///更新上传图片

uploadImage({
  ///上传类型 1：用户头像 0:其他
  required int type,
  required String imagePath,
  required Function(String imgUrl, String shortUrl) callback,
}) async {
  SmartDialog.showLoading(msg: '上传中...');
  // String path = imagePath;
  // var name = path.substring(path.lastIndexOf("-") + 1, path.length);
  // print(name);
  // List<int> imgData = File(imagePath).readAsBytesSync();

  // var img = dio.MultipartFile.fromBytes(imgData, filename: name);
  // ServiceRequest.upload(
  //   '/app/common/uploadImage.json',
  //   showProgress: false,
  //   data: {
  //     'file': img,
  //     'type': type,
  //   },
  //   success: (res) {
  //     callback.call(res['url'], res['path']);
  //   },
  //   error: (error) {},
  // );
}

///
///操作询问弹窗
showSubmitDialog({
  String? title,
  String? msg,
  List<TextEditingController>? textfieldList,
  List<String>? fieldHintTextList,
  Widget? bottomWidget,
  VoidCallback? callback,
  bool barrierDismissible = true,
  bool autoFocus = true,
}) {
  List textFieldViewList = [];
  if (textfieldList != null) {
    //如果占位符数组小于 输入框数组，则不足的用默认补齐
    if (fieldHintTextList == null) {
      fieldHintTextList = List.filled(textfieldList.length, '请输入');
    } else if (fieldHintTextList.length < textfieldList.length) {
      fieldHintTextList =
          List.filled(textfieldList.length - fieldHintTextList.length, '请输入')
            ..addAll(fieldHintTextList);
    }

    for (int i = 0; i < textfieldList.length; i++) {
      textFieldViewList.add(Padding(
        padding: EdgeInsets.only(top: 32.w),
        child: Container(
          height: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.w),
            color: AppConfig.backgroundColor,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: TextField(
            controller: textfieldList[i],
            autofocus: i == 0 ? autoFocus : false,
            decoration: InputDecoration(
              hintText: fieldHintTextList[i],
              hintStyle: TextStyle(
                color: const Color(0xffb5bcc8),
                fontSize: 28.sp,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ));
    }
  }

  CustomDialog.showCustomDialog(
    Get.context!,
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
