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
- [provider](https://pub.dev/packages/provider) —— 状态管理  
- [shared_preferences](https://pub.dev/packages/shared_preferences) —— 本地存储  
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) —— 屏幕适配  
- [logger](https://pub.dev/packages/logger) —— 日志打印  

---

## 🛠️ 注意事项
- 确保你已安装 [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- 确保 `dart run change_app_package_name:main` 可以正常执行（依赖在 `dev_dependencies` 中）  
- 如果你要自定义更多初始化步骤，可以修改 `init_project.sh`  

---

## 📄 License
MIT License
