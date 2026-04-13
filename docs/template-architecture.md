# 模版结构说明

本文档解释这个 Flutter 模版的目录职责，目的是让新项目接手人和 AI 都能快速判断“代码该放哪里”。

## 总体原则

- `app/` 放基础设施和跨模块能力
- `page/` 放业务页面
- `widget/` 放可复用 UI 组件
- 模版里的 demo 和占位页面可以删，但基础设施目录建议保留

## 目录职责

### `lib/app/config`

放项目级配置：

- 环境配置
- 主题配置
- 第三方基础参数

当前重点文件：

- `app_config.dart`
- `app_theme.dart`
- `brn_theme_config.dart`

适合放：

- `dev/test/prod` 地址
- 支付参数
- 开关类配置

不适合放：

- 页面业务逻辑
- 临时接口字段

### `lib/app/core`

放最底层、最稳定的基础设施。

当前已接入：

- `storage/storage_keys.dart`
- `storage/storage_service.dart`

后续建议继续往这里放：

- 本地缓存服务
- 数据库封装
- 设备信息服务
- 权限服务
- 崩溃上报入口

### `lib/app/routes`

放路由系统：

- `app_routes.dart` 路由常量
- `app_pages.dart` 路由注册表
- `app_middlewares.dart` 路由中间件

新增页面时，推荐顺序：

1. 新建页面文件
2. 在 `app_routes.dart` 补路由常量
3. 在 `app_pages.dart` 注册路由
4. 如果需要登录守卫，在 `app_middlewares.dart` 追加中间件

### `lib/app/utils`

放通用工具和跨页面服务入口。

当前重点文件：

- `service_request.dart`
- `logger.dart`
- `pay_manager.dart`
- `event.dart`

这里适合放：

- 网络请求封装
- 日志
- 支付管理
- 格式化器

这里不适合放：

- 只服务单个页面的私有逻辑

### `lib/page`

放业务页面，以业务域分目录。

当前示例目录：

- `auth/`
- `home/`
- `launch/`
- `legal/`
- `demo/`

推荐继续按业务域扩展，例如：

- `order/`
- `mine/`
- `cart/`
- `message/`

### `lib/widget`

放跨页面复用组件。

适合放：

- 通用按钮
- 通用弹窗
- 图片预览
- 刷新组件

不适合放：

- 强耦合单个业务模块的 UI

## 启动链路文件

这几个文件共同组成模版启动流程：

- `main.dart`
- `page/launch/bootstrap_page.dart`
- `page/launch/agreement_notice.dart`
- `page/auth/login_page.dart`
- `page/launch/launch_page.dart`

不要直接把业务首页硬写回 `main.dart`，否则会破坏模版的启动分流能力。

## 建议保留的稳定层

这些层建议作为模版长期保留：

- `app/config`
- `app/core`
- `app/routes`
- `app/utils/service_request.dart`
- `app/controller/theme_controller.dart`

## 建议按项目删除或替换的层

这些内容更偏占位或示例，新项目可直接替换：

- `page/demo`
- `page/auth/login_page.dart`
- `page/legal/legal_document_page.dart`
- `page/home/home_dashboard_page.dart`

## 结构使用原则

- 页面间跳转优先走路由常量，不要手写字符串
- 存储优先走 `StorageService`，不要直接散落 `GetStorage` 调用
- 请求优先走 `ServiceRequest`，不要在业务页直接创建 `Dio`
- 配置优先走 `AppConfig`

