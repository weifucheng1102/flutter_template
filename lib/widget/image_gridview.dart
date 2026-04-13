import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import 'photo_preview.dart';

class ImageGridView extends StatefulWidget {
  ///是否编辑模式
  final bool isEdit;

  ///图片列表
  final List<String> imageList;

  ///一行数量
  final int crossAxisCount;

  /// 最多显示的图片数量
  final int? maxImageLength;

  ///删除图片回调
  final void Function(int)? delectCallBack;

  ///添加图片回调
  final VoidCallback? addCallBack;

  final String? addImage;

  ///是否是视频
  final bool? isVideo;

  final double? ratio;

  final void Function()? onTap;
  final String? title;

  final bool? required;

  const ImageGridView({
    required this.isEdit,
    required this.imageList,
    required this.crossAxisCount,
    this.maxImageLength,
    this.delectCallBack,
    this.addCallBack,
    this.addImage,
    this.isVideo = false,
    this.onTap,
    this.ratio,
    this.title,
    this.required = false,
    super.key,
  });

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    return widget.imageList.isEmpty && !widget.isEdit
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                Padding(
                  padding: EdgeInsets.only(top: 26.w, bottom: 10.w),
                  child: Row(
                    children: [
                      if (widget.required!)
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: const Color(0xfff53d3d),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        widget.title!,
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: const Color(0xff040000),
                        ),
                      ),
                    ],
                  ),
                ),
              GridView.count(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 15.w,
                crossAxisSpacing: 15.w,

                //一行的Widget数量
                crossAxisCount: widget.crossAxisCount,
                //子Widget宽高比例
                childAspectRatio: widget.ratio ?? 1,
                //子Widget列表
                children: listItems(),
              ),
            ],
          );
  }

  List<Widget> listItems() {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < widget.imageList.length; i++) {
      final String url = widget.imageList[i];
      list.add(
        Stack(
          children: [
            InkWell(
              onTap: widget.onTap ??
                  () {
                    Get.to(
                        PhotoPreview(
                            galleryItems: widget.imageList, defaultImage: i),
                        opaque: false);
                  },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.w, right: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.w),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isEdit,
                    child: Positioned(
                      right: 0.w,
                      top: 0.w,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.delectCallBack?.call(i);
                        },
                        child: Image.asset(
                          'images/delete_image.png',
                          width: 32.w,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isVideo != null && widget.isVideo!,
                    child: Center(
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: const BoxDecoration(
                          color: Color(0x80000000),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 44.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (widget.isEdit &&
        (widget.maxImageLength == null ||
            widget.imageList.length < widget.maxImageLength!)) {
      list.add(
        GestureDetector(
          onTap: widget.addCallBack,
          child: Padding(
            padding: EdgeInsets.only(top: 5.w, right: 5.w),
            child: widget.addImage == null
                ? Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6F7),
                      borderRadius: BorderRadius.circular(24.w),
                      border: Border.all(
                        color: const Color(0xFFE4E4E4),
                        width: 1.w,
                      ),
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      size: 56.w,
                      color: const Color(0xFF999999),
                    ),
                  )
                : Image.asset(
                    widget.addImage!,
                    fit: BoxFit.fill,
                  ),
            ),
        ),
      );
    }
    return list;
  }
}
