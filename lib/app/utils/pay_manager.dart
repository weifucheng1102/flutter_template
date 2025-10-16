/*
 * @Author: 魏
 * @Date: 2025-09-08 15:40:09
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-10-16 08:43:47
 * @FilePath: /express_box/lib/app/utils/pay_manager.dart
 * @Description: 支付管理类
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:fluwx/fluwx.dart';
import 'package:tobias/tobias.dart';

import '../config/app_config.dart';

class PayManager {
  /// 单例
  PayManager._internal() {
    _init();
  }
  static final PayManager instance = PayManager._internal();

  /// 初始化
  Future<void> _init() async {
    await Fluwx().registerApi(
      appId: AppConfig.wechatPayAppid,
      universalLink: AppConfig.wechatPayIosUniversalLink,
    );

    /// 微信支付回调
    Fluwx().addSubscriber((event) {
      if (event is WeChatPaymentResponse) {
        _wxPayCallback?.call(event.errCode == 0, event.errStr);
      }
    });
  }

  Function(bool success, String? errMsg)? _wxPayCallback;

  /// 微信支付
  Future<void> wechatPay(Map<String, dynamic> payInfo,
      {Function(bool success, String? errMsg)? onResult}) async {
    _wxPayCallback = onResult;

    await Fluwx().pay(
      which: Payment(
        appId: payInfo['appid'],
        partnerId: payInfo['partnerid'],
        prepayId: payInfo['prepayid'],
        packageValue: payInfo['package'],
        nonceStr: payInfo['noncestr'],
        timestamp: int.parse(payInfo['timestamp']),
        sign: payInfo['sign'],
      ),
    );
  }

  /// 支付宝支付
  Future<void> alipayPay(String orderString,
      {Function(bool success, String? errMsg)? onResult}) async {
    try {
      final result = await Tobias().pay(orderString);

      final success = result['resultStatus'] == '9000';
      //取消支付的 不需要回调
      final bool isCancel = result['resultStatus'] == '6001';
      if (isCancel) {
        return;
      }
      onResult?.call(success, result['memo']);
    } catch (e) {
      onResult?.call(false, e.toString());
    }
  }
}
