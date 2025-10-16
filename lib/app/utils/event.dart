/*
 * @Author: 魏
 * @Date: 2025-09-04 11:37:04
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-10-16 09:12:19
 * @FilePath: /flutter_template/lib/app/utils/event.dart
 * @Description: 事件总线，用于在应用内传递事件
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */

typedef void EventCallback(arg);

class EventBus {
  //私有构造函数
  EventBus._internal();

  //保存单例
  static EventBus _singleton = new EventBus._internal();

  //工厂构造函数
  factory EventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  //添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null) return;
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = <EventCallback>[];
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }

  ///获取数量
  int getEventList(eventName) {
    var list = _emap[eventName];
    if (list == null) {
      return 0;
    }
    return list.length;
  }
}

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
var bus = new EventBus();
