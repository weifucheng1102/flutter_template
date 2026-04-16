#!/bin/bash
###
 # @Author: 魏
 # @Date: 2025-08-23
 # @LastEditors: weifucheng1102
 # @LastEditTime: 2025-09-10 08:54:25
 # @FilePath: /flutter_template/init_project.sh
 # @Description: 初始化项目模板脚本 (支持 Android & iOS 包名/目录修改)
### 

# 用法: ./init_project.sh com.yourcompany.mynewapp MyNewApp

NEW_PACKAGE=$1
NEW_NAME=$2

if [ -z "$NEW_PACKAGE" ] || [ -z "$NEW_NAME" ]; then
  echo "❌ 用法: ./init_project.sh com.yourcompany.mynewapp MyNewApp"
  exit 1
fi
# ⚠️ 校验 iOS Bundle ID 不能包含下划线 (_)
if [[ "$NEW_PACKAGE" == *"_"* ]]; then
  echo "❌ 错误: iOS bundle id 不能包含下划线 (_)，请使用点号分隔，例如: com.example.app"
  exit 1
fi
# 当前目录名
CURRENT_DIR=$(basename "$PWD")

# 如果目录名和模板名相同，则重命名目录
if [ "$CURRENT_DIR" = "flutter_template" ]; then
  cd ..
  mv flutter_template "$NEW_NAME"
  cd "$NEW_NAME"
fi

# 删除模板的 git 历史
rm -rf .git

# 安装 change_app_package_name 插件（如果没有）
echo "📦 安装 change_app_package_name 插件..."
flutter pub add -d change_app_package_name
flutter pub get

# 确保 dart 工具可用
if ! command -v dart >/dev/null 2>&1; then
  echo "❌ Dart 未安装或未加入 PATH，请先安装 Dart/Flutter"
  exit 1
fi

# 修改 Android + iOS 包名
echo "🔧 修改 Android + iOS 包名为: $NEW_PACKAGE"
dart run change_app_package_name:main "$NEW_PACKAGE"

# 修改 pubspec.yaml 项目名（macOS sed 正确写法）
echo "🔧 修改 pubspec.yaml 项目名为: $NEW_NAME"
sed -i '' "s/^name: .*/name: $NEW_NAME/" pubspec.yaml

# 修改应用显示名
echo "🔧 同步修改 Android/iOS 应用显示名为: $NEW_NAME"
sed -i '' "s/android:label=\"[^\"]*\"/android:label=\"$NEW_NAME\"/" android/app/src/main/AndroidManifest.xml
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $NEW_NAME" ios/Runner/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleName $NEW_NAME" ios/Runner/Info.plist

# Flutter 清理并获取依赖
flutter clean
flutter pub get

echo "✅ 项目已初始化完成"
echo "📦 包名: $NEW_PACKAGE"
echo "📂 工程名: $NEW_NAME"
echo "📌 Git 已删除，请执行以下命令重新初始化："
echo "   git init && git add . && git commit -m 'init'"
