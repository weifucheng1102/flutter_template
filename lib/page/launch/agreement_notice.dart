import 'dart:io';
import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../app/config/app_config.dart';
import '../../widget/custom_rich_text.dart';
import 'launch_page.dart';

class AgreementNotice extends StatefulWidget {
  const AgreementNotice({Key? key}) : super(key: key);

  @override
  State<AgreementNotice> createState() => _AgreementNoticeState();
}

class _AgreementNoticeState extends State<AgreementNotice> {
  @override
  void initState() {
    if (Platform.isIOS) {
      try {
        Dio().get('https://www.baidu.com');
      } catch (e) {}
    }
    super.initState();
  }

  Widget dialogContainer() {
    return Container(
      width: 620.w,
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 64.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.w),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            '提醒'.tr,
            style: TextStyle(
              fontSize: 36.sp,
              color: const Color(0xff1b1f24),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40.w,
          ),
          CustomRichText(
            text:
                '请你务必审慎阅读、充分理解《用户协议》和《隐私政策》各条款，包括但不限于：为了向你提供内容服务。我们需要收集你的设备信息、获取设备序列号、获取粘贴板信息和操作日志等个人信息。如你同意，请点击“同意”开始接受我们的服务。'
                    .tr,
            highlights: {
              '《用户协议》'.tr: TextStyle(
                color: AppConfig.mainColor,
                fontSize: 28.sp,
                height: 2,
              ),
              '《隐私政策》'.tr: TextStyle(
                color: AppConfig.mainColor,
                fontSize: 28.sp,
                height: 2,
              ),
            },
            onTapMap: {
              '《用户协议》'.tr: () {
                // #TODO 跳转用户协议页面
                //弹窗
                showToast('跳转用户协议');
              },
              '《隐私政策》'.tr: () {
                // #TODO 跳转隐私政策页面
                showToast('跳转隐私政策');
              },
            },
            defaultStyle: TextStyle(
              color: AppConfig.textMainColor,
              fontSize: 28.sp,
              height: 2,
            ),
          ),
          SizedBox(
            height: 56.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BrnSmallMainButton(
                title: '暂不适用'.tr,
                bgColor: const Color(0xff999999),
                onTap: () => exit(0),
              ),
              BrnSmallMainButton(
                title: '同意'.tr,
                onTap: () {
                  getbox.write('isFirst', false);

                  Get.offAll(const LaunchPage());
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.black.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: dialogContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
