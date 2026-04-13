# 模版改造清单

当你基于这个模版初始化新项目时，建议按下面清单逐项处理。

## 必改项

- 修改 `lib/app/config/app_config.dart`
  - 填 `dev/test/prod` 的 `baseUrl`
  - 填微信支付参数
- 修改 `pubspec.yaml`
  - 改项目 `name`
  - 删除不需要的依赖
- 修改应用名和包名
  - 执行 `init_project.sh`
- 替换协议文案
  - `lib/page/launch/agreement_notice.dart`
  - `lib/page/legal/legal_document_page.dart`
- 替换登录页
  - `lib/page/auth/login_page.dart`
- 替换首页工作台
  - `lib/page/home/home_dashboard_page.dart`

## 高优先级建议

- 检查是否保留支付能力
  - `fluwx`
  - `tobias`
- 检查 `networkWarmupUrl` 是否替换为你自己的轻量健康检查接口
- 检查是否保留图片选择能力
  - `image_pickers`
- 检查是否保留二维码扫描能力
  - `qr_code_scanner_plus`
- 检查是否保留 Bruno
  - 如果新项目不需要 Bruno，可整体移除

## 路由接入步骤

新功能页接入推荐顺序：

1. 新建页面文件
2. 在 `app_routes.dart` 定义路由名
3. 在 `app_pages.dart` 注册页面
4. 如果页面需要登录，再补中间件

## 存储使用约束

- 不要直接在业务代码里写裸 key
- 统一通过 `StorageKeys`
- 统一通过 `StorageService`

## 网络层改造建议

如果你的后端返回结构不是：

```json
{
  "result": 1,
  "info": "success"
}
```

那么应该优先修改：

- `lib/app/utils/service_request.dart`

而不是在每个页面单独写解析逻辑。

## UI 层建议

- 页面业务 UI 放 `page/`
- 可复用组件放 `widget/`
- 全局主题统一从 `AppColorScheme` 取值

## 交付前建议检查

- `flutter analyze`
- `flutter test`
- Android 签名配置
- iOS 通用链接和支付配置
- README 是否已替换成项目说明
- 是否删除了不需要的 demo 页面
