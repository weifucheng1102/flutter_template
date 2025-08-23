#!/bin/bash
###
 # @Author: 魏
 # @Date: 2025-08-23 09:24:15
 # @LastEditors: weifucheng1102
 # @LastEditTime: 2025-08-23 09:24:27
 # @FilePath: /flutter_template/init_project.sh
 # @Description: 初始化项目模版脚本
 # 
 # Copyright (c) 2025 by 魏, All Rights Reserved. 
### 
# 用法: ./init_project.sh com.yourcompany.mynewapp MyNewApp

NEW_PACKAGE=$1
NEW_NAME=$2

if [ -z "$NEW_PACKAGE" ] || [ -z "$NEW_NAME" ]; then
  echo "❌ 用法: ./init_project.sh com.yourcompany.mynewapp MyNewApp"
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

# 修改包名
flutter pub run change_app_package_name:main $NEW_PACKAGE

# 修改 pubspec.yaml 里的 name
sed -i '' "s/^name: .*/name: $NEW_NAME/" pubspec.yaml

# Flutter 清理并获取依赖
flutter clean
flutter pub get

echo "✅ 项目已初始化完成"
echo "   包名      = $NEW_PACKAGE"
echo "   工程名    = $NEW_NAME"
echo "   Git 已删除，请执行以下命令重新初始化："
echo "   git init && git add . && git commit -m 'init'"
