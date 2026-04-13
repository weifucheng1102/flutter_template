import 'package:get_storage/get_storage.dart';

import 'storage_keys.dart';

class StorageService {
  StorageService._();

  static final GetStorage _box = GetStorage();

  /// 保留最基础的读写封装，避免业务层直接接触裸 key。
  static T? read<T>(String key) => _box.read<T>(key);

  static Future<void> write(String key, dynamic value) => _box.write(key, value);

  static Future<void> remove(String key) => _box.remove(key);

  static Future<void> erase() => _box.erase();

  static bool get hasToken => (token?.isNotEmpty ?? false);

  static String? get token => read<String>(StorageKeys.token);

  static Future<void> saveToken(String value) => write(StorageKeys.token, value);

  static Future<void> clearToken() => remove(StorageKeys.token);

  static bool get hasAcceptedAgreement =>
      read<bool>(StorageKeys.hasAcceptedAgreement) ?? false;

  static Future<void> acceptAgreement() =>
      write(StorageKeys.hasAcceptedAgreement, true);

  static bool get isChecking => read<bool>(StorageKeys.isChecking) ?? false;

  static List<dynamic> get permissionList =>
      read<List<dynamic>>(StorageKeys.permissionList) ?? <dynamic>[];

  static Future<void> savePermissionList(List<dynamic> values) =>
      write(StorageKeys.permissionList, values);
}
