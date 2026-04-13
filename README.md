
# Flutter Template 🚀

这是一个 Flutter 项目模板，预置了常用依赖和项目结构。  
你可以基于它快速创建新的 Flutter 项目，而不必每次都从零开始。

---

## 🔧 使用方法

### 1. 克隆模板仓库
```bash
git clone https://github.com/weifucheng1102/flutter_template
cd flutter_template
```

### 2. 赋予脚本执行权限（只需第一次）
```bash
chmod +x init_project.sh
```

### 3. 初始化新项目
```bash
./init_project.sh com.mycompany.myapp MyApp
```
- `com.mycompany.myapp` 👉 新项目的包名（Android packageName / iOS bundleId）  
- `MyApp` 👉 新项目的名字（工程文件夹名 + pubspec.yaml name）  

执行完成后会自动：
- 修改 Android 包名和 iOS Bundle Id  
- 修改 `pubspec.yaml` 的 `name`  
- 删除 `.git`（避免继承模板仓库历史）  
- 如果目录名是 `flutter_template`，会改成新项目名  
- 执行 `flutter clean && flutter pub get`  

---

## ⚡ 初始化 Git 仓库
脚本执行完会提示你重新初始化 Git：  
```bash
git init
git add .
git commit -m "init"
```
如果你要推送到 GitHub/GitLab，可以直接：  
```bash
git remote add origin https://github.com/yourname/myapp.git
git push -u origin main
```

---

## 📦 预置依赖
模板中预置了一些常用依赖（可按需修改 `pubspec.yaml`）：  
- [dio](https://pub.dev/packages/dio) —— 网络请求  
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) —— 屏幕适配  
- [get_storage](https://pub.dev/packages/get_storage) —— 本地存储  
- [get](https://pub.dev/packages/get) —— 状态管理  
- [logger](https://pub.dev/packages/logger) —— 日志打印  
- [package_info_plus](https://pub.dev/packages/package_info_plus) —— 应用信息  
- [path_provider](https://pub.dev/packages/path_provider) —— 路径操作
- [common_utils](https://pub.dev/packages/common_utils) —— 常用工具
- [flutter_keyboard_visibility](https://pub.dev/packages/flutter_keyboard_visibility) —— 键盘监听
- [flutter_smart_dialog](https://pub.dev/packages/flutter_smart_dialog) —— 弹窗管理
- [flutter_widget_from_html_core](https://pub.dev/packages/flutter_widget_from_html_core) —— 富文本解析
- [cached_network_image](https://pub.dev/packages/cached_network_image) —— 图片缓存
- [permission_handler](https://pub.dev/packages/permission_handler) —— 权限申请
- [device_info_plus](https://pub.dev/packages/device_info_plus) —— 设备信息
- [bruno](https://github.com/LianjiaTech/bruno.git) —— 常用组件
- [dynamic_height_grid_view](https://pub.dev/packages/dynamic_height_grid_view) —— 自适应gridview
- [image_pickers]( https://github.com/weifucheng1102/image_pickers.git) —— 图片选择
- [oktoast](https://pub.dev/packages/oktoast) —— toast 弹窗
- [card_swiper](https://pub.dev/packages/card_swiper) —— 轮播图
- [easy_refresh](https://pub.dev/packages/easy_refresh) —— 刷新
- [url_launcher](https://pub.dev/packages/url_launcher) —— 打开链接
- [dismissible_page](https://pub.dev/packages/dismissible_page) —— 消除页面
- [fluwx](https://pub.dev/packages/fluwx) —— 微信支付
- [tobias](https://pub.dev/packages/tobias) —— 支付宝支付

---

## 🎨 主题色使用
模板已内置主题色配置，统一由 `AppColorScheme` 管理。

### 1. 修改默认主题色
在 `lib/app/config/app_theme.dart` 中调整 `mainColor`：  
- 浅色：`AppTheme.lightColors.mainColor`  
- 深色：`AppTheme.darkColors.mainColor`  

### 2. 在组件中使用主题色
```dart
final colors = Theme.of(context).extension<AppColorScheme>()!;
final primary = colors.mainColor;
```

也可以使用全局 `colors` getter（无需 `BuildContext`）：  
```dart
import 'app/common/theme_colors.dart';

final primary = colors.mainColor;
```

### 3. 切换浅色/深色主题
运行时调用：  
```dart
ThemeController.to.setThemeMode(ThemeMode.light); // 浅色
ThemeController.to.setThemeMode(ThemeMode.dark);  // 深色
ThemeController.to.setThemeMode(ThemeMode.system); // 跟随系统
```
或使用快捷切换：  
```dart
ThemeController.to.toggleThemeMode();
```

---

## 🛠️ 注意事项
- 确保你已安装 [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- 确保 `dart run change_app_package_name:main` 可以正常执行（依赖在 `dev_dependencies` 中）  
- 如果你要自定义更多初始化步骤，可以修改 `init_project.sh`  
- ⚠️ **包名/Bundle ID 不允许包含下划线 `_`**  
  - ✅ 正确: `com.example.myapp`  
  - ❌ 错误: `com.example.my_app` （iOS 不支持下划线，会导致打包失败）

### 🔑 Android 签名秘钥配置
为了打包发布 Android 应用，你需要添加自己的签名秘钥：

1. 将你的 keystore 文件放到项目的 `android/app/keystore/` 目录下，例如：
```
android/app/keystore/my-release-key.jks
```

2. 打开 `android/key.properties` 文件，修改以下内容：
```properties
storePassword=<你的 keystore 密码>
keyPassword=<你的 key 密码>
keyAlias=<你的 key 别名>
storeFile=keystore/my-release-key.jks
```

3. 保存后，执行 Flutter 打包命令即可：
```bash
flutter build apk --release
# 或者
flutter build appbundle --release
```

> ⚠️ 注意：不要将 keystore 文件提交到 Git 仓库，可以在 `.gitignore` 里忽略。

---

## 📄 License
MIT License
