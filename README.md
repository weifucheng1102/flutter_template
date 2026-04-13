# Flutter Template

这是一个面向业务项目初始化的 Flutter 模版，不只是依赖集合，还包含了基础启动链路、环境配置、路由骨架、登录态存储、主题切换和常用工具层。

## 模版定位

适合拿来做这些事：

- 快速初始化一个中后台、工具类、商城类或内容类 Flutter App
- 保留统一的网络层、主题层、路由层、存储层写法
- 作为团队内部新项目的起步基线

当前内置骨架包括：

- `dart-define` 环境切换
- `GetMaterialApp` 路由表与未知路由兜底
- 启动分流页 `BootstrapPage`
- 协议页、登录页、首页、设置页、受保护页面示例
- `GetStorage` 登录态与协议状态封装
- `Dio` 单例请求入口与拦截器
- 全局异常捕获入口
- 明暗主题切换

## 文档索引

为了方便后续人工开发和 AI 协作，模板补充了结构文档和代理说明：

- `docs/template-architecture.md`：目录职责和结构边界
- `docs/template-startup-flow.md`：启动链路说明
- `docs/template-customization-checklist.md`：新项目改造清单
- `docs/module-template.md`：新业务模块接入规范
- `AGENTS.md`：面向 AI 开发代理的仓库协作说明

## 初始化项目

```bash
git clone https://github.com/weifucheng1102/flutter_template
cd flutter_template
chmod +x init_project.sh
./init_project.sh com.mycompany.myapp my_app
```

初始化脚本会自动：

- 修改 Android 包名和 iOS Bundle ID
- 修改 `pubspec.yaml` 中的项目名
- 删除原模板 `.git`
- 执行依赖拉取

## 推荐目录

```text
lib/
  app/
    config/
    controller/
    core/
      storage/
    routes/
    utils/
  page/
    auth/
    home/
    launch/
    legal/
    demo/
  widget/
```

`app/core` 放基础设施，`page` 放业务页，`widget` 放复用 UI 组件。这种结构比把所有逻辑平铺在 `app/` 里更适合长期演进。

## 环境配置

环境配置在 [lib/app/config/app_config.dart](lib/app/config/app_config.dart)。

你需要至少补这 3 套信息：

- `dev`
- `test`
- `prod`

重点字段：

- `baseUrl`
- `networkWarmupUrl`
- `wechatPayAppid`
- `wechatPayIosUniversalLink`

运行方式：

```bash
flutter run --dart-define=APP_ENV=dev
flutter run --dart-define=APP_ENV=test
flutter run --dart-define=APP_ENV=prod
```

也可以直接使用脚本：

```bash
bash scripts/run_dev.sh
bash scripts/run_test_env.sh
bash scripts/run_prod.sh
```

`networkWarmupUrl` 用于 iOS 首次启动时提前触发网络访问授权。模板当前保留了 `https://www.baidu.com` 作为兼容示例，但更建议替换成你自己的轻量健康检查接口。

这里解决的不是普通权限申请，而是 iOS 首次数据网络访问时的系统授权场景。模板已经内置了预热和失败后自动补一次请求的逻辑，避免首个业务请求因为首次授权而直接丢失。

## 启动链路

当前启动流程：

1. 进入 `BootstrapPage`
2. 未同意协议，跳转协议页
3. 已同意协议但未登录，跳转登录页
4. 已登录，进入主壳页面

相关文件：

- `lib/page/launch/bootstrap_page.dart`
- `lib/page/launch/agreement_notice.dart`
- `lib/page/auth/login_page.dart`
- `lib/page/launch/launch_page.dart`

## 路由骨架

当前已经接入：

- 路由常量 `lib/app/routes/app_routes.dart`
- 路由表 `lib/app/routes/app_pages.dart`
- 登录中间件示例 `lib/app/routes/app_middlewares.dart`

模板里保留了一个“受保护页面”示例，未登录访问会自动跳转登录页。后续你可以照这个方式扩展业务守卫。

## 存储层

不要再在业务代码里散落裸字符串 key。模板已经提供：

- `StorageKeys`
- `StorageService`

当前内置管理：

- token
- 协议确认状态
- 权限申请记录
- 审核模式标记

## 网络层

模板的请求入口是 `lib/app/utils/service_request.dart`，当前特性：

- 单例 `Dio`
- 统一超时
- 拦截器日志
- token 自动注入
- 统一错误兜底
- `baseUrl` 未配置时直接拦截

如果你后续项目接口协议不是 `result/info` 这种格式，建议优先改这里，不要在业务页到处补判断。

## 新项目落地建议

拿这个模板起项目后，建议先做这几件事：

1. 补齐 `AppConfig` 三套环境配置
2. 替换协议文案、登录页和首页骨架
3. 确认是否保留微信支付、支付宝支付、图片选择这些依赖
4. 删除不需要的 demo 页面
5. 增加项目自己的业务模块目录

## 常用命令

```bash
flutter analyze
flutter test
flutter pub outdated
flutter build apk --release --dart-define=APP_ENV=prod
flutter build ipa --dart-define=APP_ENV=prod
```

## Android 签名

发布前请配置：

```properties
storePassword=<你的 keystore 密码>
keyPassword=<你的 key 密码>
keyAlias=<你的 key 别名>
storeFile=keystore/my-release-key.jks
```

文件位置：

`android/key.properties`

不要把 keystore 提交进仓库。
