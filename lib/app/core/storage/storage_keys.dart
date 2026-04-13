class StorageKeys {
  StorageKeys._();

  /// 登录态 token，后续可替换成 accessToken/refreshToken 结构。
  static const String token = 'token';

  /// 首次启动是否已同意协议。
  static const String hasAcceptedAgreement = 'hasAcceptedAgreement';

  /// 权限申请记录，用于审核场景避免重复弹窗。
  static const String permissionList = 'permissionList';

  /// 是否处于审核模式。
  static const String isChecking = 'isChecking';
}
