import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'empty_view.dart';

class CustomRefresh extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onLoad;
  final Future<void> Function()? onRefresh;
  final int count;
  final Widget? emptyWidget;
  final Header? header;
  final Footer? footer;
  const CustomRefresh({
    Key? key,
    required this.count,
    required this.child,
    this.onLoad,
    this.onRefresh,
    this.emptyWidget,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  State<CustomRefresh> createState() => _CustomRefreshState();
}

class _CustomRefreshState extends State<CustomRefresh> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: widget.header ?? const MaterialHeader(),
      footer: widget.footer ?? const MaterialFooter(),
      onLoad: widget.onLoad,
      onRefresh: widget.onRefresh,
      child: widget.count == 0
          ? ListView(
              children: [
                widget.emptyWidget ?? const EmptyView(),
              ],
            )
          : widget.child,
    );
  }
}
