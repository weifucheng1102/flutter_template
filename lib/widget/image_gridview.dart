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
  final List imageList;

  ///一行数量
  final int crossAxisCount;

  /// 最多显示的图片数量
  final int? maxImageLength;

  ///删除图片回调
  final Function(int)? delectCallBack;

  ///添加图片回调
  final Function? addCallBack;

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
    Key? key,
  }) : super(key: key);

  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    return widget.imageList.isEmpty && !widget.isEdit
        ? Container()
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
                          color: Color(0xff040000),
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
    List<Widget> list = [];
    for (var i = 0; i < widget.imageList.length; i++) {
      String url = widget.imageList[i];
      // if (!url.contains('x-oss-process=')) {
      //   if (widget.isVideo != null && widget.isVideo!) {
      //     url = '$url?x-oss-process=video/snapshot,t_0,h_300';
      //   } else {
      //     url = '$url?x-oss-process=image/resize,h_300,m_lfit';
      //   }
      // }
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
                          print('2');
                          widget.delectCallBack!(i);
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
                      child: Image.asset(
                        'images/video_play.png',
                        width: 60.w,
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
          onTap: () {
            if (widget.addCallBack != null) {
              widget.addCallBack!();
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: 5.w, right: 5.w),
            // padding: EdgeInsets.zero,
            child: Image.asset(
              widget.addImage == null
                  ? 'images/add_image.png'
                  : widget.addImage!,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    }
    return list;
  }
}
