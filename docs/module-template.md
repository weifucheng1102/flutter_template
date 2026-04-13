# 模块开发规范

这个文档用于约束新业务模块怎么接入模板，避免项目长大后目录和职责失控。

## 新模块推荐结构

以 `order` 模块为例：

```text
lib/page/order/
  order_list_page.dart
  order_detail_page.dart
  widgets/
    order_card.dart
    order_filter_bar.dart
```

如果模块足够复杂，可以继续拆：

```text
lib/page/order/
  controller/
  model/
  service/
  widgets/
```

## 接入步骤

1. 新建页面目录和页面文件
2. 在 `lib/app/routes/app_routes.dart` 增加路由常量
3. 在 `lib/app/routes/app_pages.dart` 注册页面
4. 如果需要登录保护，挂到中间件
5. 如需本地持久化，优先扩展 `StorageKeys` 和 `StorageService`

## 推荐约束

- 页面文件名统一 `xxx_page.dart`
- 当前模块私有小组件放到模块自己的 `widgets/`
- 全局可复用组件才放到 `lib/widget/`
- 不要在页面里直接 `Dio()` 或 `GetStorage()`

## 数据和网络

- 通用请求统一走 `ServiceRequest`
- 如果模块接口很多，可以在模块目录内新增 `service/` 封装
- 但底层发送请求仍建议复用统一入口

## 状态管理

当前模板默认使用 `GetX`。

推荐做法：

- 页面级控制器放模块目录下
- 主题、环境、全局状态保留在 `app/`
- 不要把所有控制器都堆到 `app/controller`

## AI 协作建议

如果让 AI 新增模块，建议明确告诉它：

- 模块名
- 是否需要登录守卫
- 页面数量
- 是否需要本地存储
- 是否需要接口封装

这样它更容易遵守模板结构，而不是到处乱放文件。
