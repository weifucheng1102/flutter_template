import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:oktoast/oktoast.dart';

import 'package:permission_handler/permission_handler.dart';

import '../app/common/common.dart';
import 'custom_bottom_sheet.dart';

typedef PickerCallback = void Function(List<Media> imageList);

class CustomImagePicker {
  static void pickImage(
    BuildContext context, {
    required int count,
    required PickerCallback pickerCallback,
    bool isVideo = false,
    bool enableCrop = false,
  }) {
    // final ImagePicker picker = ImagePicker();

    CustomButtomSheet.showText(context, dataArr: ['相册', '相机'],
        clickCallBack: (index, item) async {
      FocusScope.of(context).requestFocus(FocusNode());
      if (index == 1) {
        bool isSuccess = false;
        if (Platform.isAndroid) {
          isSuccess =
              await requestPermission(Permission.camera, '上传头像等功能需要访问相机权限');
        } else {
          isSuccess = true;
        }

        if (isSuccess) {
          ImagePickers.openCamera(
            cameraMimeType:
                isVideo ? CameraMimeType.video : CameraMimeType.photo,
            cropConfig: CropConfig(
              enableCrop: enableCrop,
            ),
          ).then((value) {
            if (value != null) {
              pickerCallback([value]);
            }
          });
        } else {
          SmartDialog.showToast('相机权限被拒绝');
        }
      } else {
        bool permissionSuccess = false;
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
          if ((androidInfo.version.sdkInt) >= 33) {
            if (isVideo) {
              permissionSuccess =
                  await requestPermission(Permission.videos, '上传头像等功能需要访问相册权限');
            } else {
              permissionSuccess =
                  await requestPermission(Permission.photos, '上传头像等功能需要访问相册权限');
            }
          } else {
            permissionSuccess =
                await requestPermission(Permission.storage, '上传头像等功能需要访问存储权限');
          }
        } else {
          permissionSuccess = true;
        }

        if (permissionSuccess) {
          ImagePickers.pickerPaths(
                  galleryMode: isVideo ? GalleryMode.video : GalleryMode.image,
                  selectCount: count,
                  videoSelectMaxSecond: 3600,
                  cropConfig: CropConfig(
                    enableCrop: enableCrop,
                  ),
                  uiConfig: UIConfig(uiThemeColor: Colors.black))
              .then((List<Media> value) {
            pickerCallback(value);
          });
        } else {
          showToast('相册权限被拒绝');
        }
      }
    });
  }
}
