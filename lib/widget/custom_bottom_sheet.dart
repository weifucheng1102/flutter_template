import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

import '../app/config/app_config.dart';

typedef MultClickCallback = void Function(
    List selectIndexs, List selectStrings);

class CustomButtomSheet {
  //弹出底部文字
  static void showText(
    BuildContext context, {
    required List dataArr,
    String? title,
    void Function(int, BrnCommonActionSheetItem)? clickCallBack,
    int? selectIndex,
  }) {
    ///弹窗时 关闭输入框
    FocusScope.of(context).requestFocus(FocusNode());

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BrnCommonActionSheet(
            title: title,
            actions: List.generate(
              dataArr.length,
              (index) => BrnCommonActionSheetItem(
                dataArr[index],
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                  color: (selectIndex ?? -1) == index
                      ? AppConfig.mainColor
                      : Colors.black,
                ),
              ),
            ),
            clickCallBack: clickCallBack,
          );
        });
  }

  ///多个选择
  static showMultiChoiceModalBottomSheet(
    BuildContext context, {
    required List options,
    required List selectIndex,
    String? title,
    MultClickCallback? multClickCallback,
  }) async {
    List selected = selectIndex;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context1, setState) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                topRight: Radius.circular(20.w),
              ),
            ),
            height: 0.5.sh,
            child: Column(
              children: [
                BrnAppBar(
                  title: title,
                  leadingWidth: 200.w,
                  leading: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            '取消',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: AppConfig.textMainColor,
                            ),
                          )),
                    ],
                  ),
                  actions: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (multClickCallback != null) {
                        multClickCallback(
                          selected,
                          options
                              .where(
                                (element) => selected.contains(
                                  options.indexOf(element),
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      '完成',
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppConfig.mainColor,
                      ),
                    )),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: Icon(
                          selected.contains(index)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppConfig.mainColor,
                        ),
                        title: Text(
                          options[index],
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (selected.contains(index)) {
                              selected.remove(index);
                            } else {
                              selected.add(index);
                            }
                          });
                        },
                      );
                    },
                    itemCount: options.length,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  //弹出底部文字
  static Future showDialog(Widget child) {
    return Get.bottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          child,
        ],
      ),
      isScrollControlled: true,
    );
  }
}
