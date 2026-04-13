# AGENTS.md

本文件用于指导后续接入本仓库的 AI 开发代理。目标不是解释 Flutter 基础知识，而是告诉代理：这个仓库的模板目标、代码边界、推荐修改路径和禁区。

## 目标

这是一个 Flutter 业务模板项目，不是单一业务 App。代理在修改代码时，应优先维护模板的可复用性，而不是只满足某一个临时页面需求。

## 输出语言

- 始终使用中文简体回复

## 工作原则

- 优先维护模板骨架稳定性
- 优先修改基础设施入口，而不是在业务页打补丁
- 保留可复用结构，不要把模板改成一次性项目
- 变更前先理解启动链路、路由链路、存储链路

## 仓库重点结构

### `lib/app/config`

项目级配置。

- `app_config.dart`：环境配置、支付配置
- `app_theme.dart`：主题扩展

### `lib/app/core`

基础设施层。

- `storage_keys.dart`
- `storage_service.dart`

### `lib/app/routes`

路由体系。

- `app_routes.dart`
- `app_pages.dart`
- `app_middlewares.dart`

### `lib/app/utils`

跨业务通用工具。

- `service_request.dart`
- `logger.dart`
- `pay_manager.dart`

### `lib/page`

业务页面骨架。

- `launch/` 启动流程
- `auth/` 登录骨架
- `home/` 首页和设置页骨架
- `legal/` 协议文档页
- `demo/` 示例页面

## 启动链路

不要直接跳过启动分流。

当前链路：

1. `main.dart`
2. `BootstrapPage`
3. `AgreementNotice` / `LoginPage` / `LaunchPage`

如果要改首页进入逻辑，优先改 `BootstrapPage`，不要把判断重新塞回 `main.dart`。

## 路由规则

- 新页面必须优先补路由常量
- 新页面必须注册到 `app_pages.dart`
- 需要登录保护的页面，应通过中间件处理
- 不要在业务代码里散落路由字符串

## 存储规则

- 不要直接散落 `GetStorage().read/write`
- 优先使用 `StorageService`
- 不要新增裸字符串 key，先补到 `StorageKeys`

## 网络层规则

- 不要在页面里直接 `Dio()` 发请求
- 统一走 `ServiceRequest`
- 如果需要改接口协议解析，优先改 `service_request.dart`
- 如果业务需要专属 API 层，可以在 `app/utils` 或 `app/core/network` 扩展，但不要绕开统一入口

## 模板特性保护

以下能力默认视为模板能力，不要随意删除，除非用户明确要求：

- 环境切换
- 统一路由表
- 启动分流
- 登录态存储
- 主题切换
- 通用请求入口

## 允许替换的占位内容

这些内容是模板占位，允许按需求替换：

- 登录页
- 协议文案
- 首页工作台
- 设置页文案
- demo 页面

## 注释要求

- 关键骨架、基础设施入口、路由守卫、启动分流应保留简洁注释
- 不要写无意义注释
- 注释重点解释“为什么这样做”，不是解释语法

## 文档约定

修改模板骨架后，优先同步更新这些文档：

- `README.md`
- `docs/template-architecture.md`
- `docs/template-startup-flow.md`
- `docs/template-customization-checklist.md`
- `docs/module-template.md`

## 变更完成后的检查

- 运行 `flutter analyze`
- 如条件允许，运行 `flutter test`
- 确认 README 或 docs 是否需要同步
- 确认是否破坏模板复用性
