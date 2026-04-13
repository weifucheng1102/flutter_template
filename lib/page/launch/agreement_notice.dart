import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/common/theme_colors.dart';
import '../../app/core/network/network_warmup_service.dart';
import '../../app/core/storage/storage_service.dart';
import '../../app/routes/app_routes.dart';
import '../../widget/custom_rich_text.dart';
import '../legal/legal_document_page.dart';

class AgreementNotice extends StatefulWidget {
  const AgreementNotice({super.key});

  @override
  State<AgreementNotice> createState() => _AgreementNoticeState();
}

class _AgreementNoticeState extends State<AgreementNotice> {
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
                color: colors.mainColor,
                fontSize: 28.sp,
                height: 2,
              ),
              '《隐私政策》'.tr: TextStyle(
                color: colors.mainColor,
                fontSize: 28.sp,
                height: 2,
              ),
            },
            onTapMap: {
              '《用户协议》'.tr: () {
                Get.toNamed(
                  AppRoutes.legal,
                  arguments: const LegalDocumentArgs(
                    title: '用户协议',
                    content: '这里放用户协议模板内容。建议在新项目中替换为正式协议文案。',
                  ),
                );
              },
              '《隐私政策》'.tr: () {
                Get.toNamed(
                  AppRoutes.legal,
                  arguments: const LegalDocumentArgs(
                    title: '隐私政策',
                    content: '这里放隐私政策模板内容。建议在新项目中替换为正式隐私政策文案。',
                  ),
                );
              },
            },
            defaultStyle: TextStyle(
              color: colors.textMainColor,
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
                onTap: SystemNavigator.pop,
              ),
              BrnSmallMainButton(
                title: '同意'.tr,
                onTap: () async {
                  await StorageService.acceptAgreement();
                  await NetworkWarmupService.ensureReady();
                  if (StorageService.hasToken) {
                    Get.offAllNamed(AppRoutes.launch);
                    return;
                  }
                  Get.offAllNamed(AppRoutes.login);
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
        color: Colors.black.withValues(alpha: 0.6),
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
