/*
 * @Author: 魏
 * @Date: 2025-02-08 14:22:55
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-09-04 09:31:16
 * @FilePath: /express_box/lib/app/widget/photo_preview.dart
 * @Description: 图片显示
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);

class PhotoPreview extends StatefulWidget {
  final List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged? pageChanged; //切换图片回调
  final Axis direction; //图片查看方向
  final BoxDecoration? decoration; //背景设计
  final bool isLocal;

  const PhotoPreview({
    super.key,
    required this.galleryItems,
    required this.defaultImage,
    this.pageChanged,
    this.direction = Axis.horizontal,
    this.decoration,
    this.isLocal = false,
  });
  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  int? tempSelect;
  @override
  void initState() {
    super.initState();
    tempSelect = widget.defaultImage + 1;
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Get.back();
      },
      child: InkWell(
        onTap: () => Get.back(),
        child: Stack(
          children: [
            PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return widget.isLocal
                      ? PhotoViewGalleryPageOptions(
                          imageProvider:
                              FileImage(File(widget.galleryItems[index])),
                        )
                      : PhotoViewGalleryPageOptions(
                          imageProvider: CachedNetworkImageProvider(
                              widget.galleryItems[index]),
                        );
                },
                scrollDirection: widget.direction,
                itemCount: widget.galleryItems.length,
                backgroundDecoration: widget.decoration ??
                    const BoxDecoration(color: Colors.transparent),
                pageController:
                    PageController(initialPage: widget.defaultImage),
                onPageChanged: (index) => setState(() {
                      tempSelect = index + 1;
                      if (widget.pageChanged != null) {
                        widget.pageChanged!(index);
                      }
                    })),
            Positioned(
              ///布局自己换
              right: 20,
              top: 20,
              child: SafeArea(
                child: Text(
                  '$tempSelect/${widget.galleryItems.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
