import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/config/app_config.dart';

class CustomLabel extends StatelessWidget {
  final Widget? image;
  final String label;
  final String? desc;
  final String input;
  final String? tip;
  final double? height;
  final String? bottomLabel;
  final TextStyle? labelStyle;
  final TextStyle? inputStyle;
  final TextStyle? tipStyle;
  final TextStyle? bottomLabelStyle;
  final TextEditingController? textCon;
  final TextAlign? textfieldAlign;

  final bool hasRight;
  final bool hasBottomLine;
  final Widget? rightWidget;
  final VoidCallback? callback;
  final bool textfieldReadOnly;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final TextStyle? textfieldStyle;
  final int? textfieldMaxLength;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final Widget? rightImagePicture;
  final bool required;

  /// ```dart
  /// labelStyle:
  /// TextStyle(
  ///    fontSize: 28.sp,
  ///    color: const Color(0xff333333),
  ///      ),
  /// inputStyle:
  /// TextStyle(
  ///    fontSize: 26.sp,
  ///    color: const Color(0xffafafaf),
  ///      ),
  /// ```
  const CustomLabel({
    required this.label,
    required this.input,
    this.desc,
    this.tip,
    this.height,
    this.bottomLabel,
    this.labelStyle,
    this.inputStyle,
    this.tipStyle,
    this.bottomLabelStyle,
    this.image,
    this.hasRight = false,
    this.hasBottomLine = false,
    this.rightWidget,
    this.callback,
    this.textCon,
    this.textfieldAlign,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.textfieldStyle,
    this.textfieldMaxLength,
    this.focusNode,
    this.inputFormatters,
    this.onChanged,
    this.rightImagePicture,
    this.required = false,
    this.textfieldReadOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        height: height ?? 100.w,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  bottomLabel != null
                      ? bottomLabelWidget()
                      : Row(
                          children: [
                            if (image != null)
                              Padding(
                                padding: EdgeInsets.only(right: 22.w),
                                child: image,
                              ),
                            labelWidget(),
                            Text(
                              desc ?? '',
                              style: TextStyle(
                                fontSize: 26.sp,
                                color: AppConfig.textSubColor,
                              ),
                            ),
                          ],
                        ),
                  if (bottomLabel != null)
                    SizedBox(
                      width: 10.w,
                    ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        rightWidget ??
                            (textCon == null
                                ? Expanded(
                                    child: Text(
                                      input.isEmpty && tip != null
                                          ? tip!
                                          : input,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: input.isEmpty && tip != null
                                          ? (tipStyle ??
                                              TextStyle(
                                                fontSize: 28.sp,
                                                color: AppConfig.textSubColor,
                                              ))
                                          : (inputStyle ??
                                              TextStyle(
                                                fontSize: 28.sp,
                                                color: AppConfig.textMainColor,
                                              )),
                                    ),
                                  )
                                : Expanded(
                                    child: TextField(
                                    style: textfieldStyle ??
                                        TextStyle(
                                          fontSize: 28.sp,
                                          color: AppConfig.textMainColor,
                                        ),
                                    focusNode: focusNode,
                                    maxLength: textfieldMaxLength,
                                    readOnly: textfieldReadOnly,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: tip ?? '',
                                      hintStyle: tipStyle ??
                                          TextStyle(
                                            fontSize: 28.sp,
                                            color: AppConfig.textSubColor,
                                          ),
                                    ),
                                    inputFormatters: inputFormatters,
                                    textAlign: textfieldAlign ?? TextAlign.end,
                                    controller: textCon,
                                    obscureText: isObscure!,
                                    keyboardType: keyboardType,
                                    onChanged: onChanged,
                                  ))),
                        Visibility(
                          visible: hasRight,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: rightImagePicture ??
                                Image.asset(
                                  'images/right.png',
                                  width: 36.w,
                                  fit: BoxFit.fill,
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: hasBottomLine,
              child: Container(
                height: 1.w,
                color: AppConfig.lineColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomLabelWidget() {
    return Row(
      children: [
        if (image != null)
          Padding(
            padding: EdgeInsets.only(right: 22.w),
            child: image,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            labelWidget(),
            SizedBox(
              height: 8.w,
            ),
            Text(
              bottomLabel!,
              style: bottomLabelStyle ??
                  TextStyle(
                    fontSize: 22.sp,
                    color: const Color(0xffafafaf),
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget labelWidget() {
    return Text.rich(
      TextSpan(children: [
        if (required)
          TextSpan(
            text: '*',
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xfff53d3d),
              fontWeight: FontWeight.bold,
            ),
          ),
        TextSpan(
          text: label,
          style: labelStyle ??
              TextStyle(
                fontSize: 28.sp,
                color: AppConfig.textMainColor,
              ),
        ),
      ]),
    );
  }
}
