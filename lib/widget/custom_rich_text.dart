/*
 * @Author: 魏
 * @Date: 2025-05-28 15:25:54
 * @LastEditors: weifucheng1102
 * @LastEditTime: 2025-09-13 10:11:16
 * @FilePath: /express_box/lib/app/widget/custom_rich_text.dart
 * @Description: 自定义富文本
 * 
 * Copyright (c) 2025 by 魏, All Rights Reserved. 
 */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final Map<String, TextStyle> highlights;
  final TextStyle? defaultStyle;
  final bool caseSensitive;
  final Map<String, VoidCallback>? onTapMap; // 点击回调

  const CustomRichText({
    Key? key,
    required this.text,
    required this.highlights,
    this.defaultStyle,
    this.caseSensitive = true,
    this.onTapMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (highlights.isEmpty) {
      return Text(text, style: defaultStyle);
    }

    final entries = highlights.entries.toList();
    final lowerText = caseSensitive ? text : text.toLowerCase();
    final matches = <_Match>[];

    for (var entry in entries) {
      final keyword = caseSensitive ? entry.key : entry.key.toLowerCase();
      int start = 0;
      while (true) {
        final index = lowerText.indexOf(keyword, start);
        if (index == -1) break;
        matches.add(
            _Match(index, index + entry.key.length, entry.key, entry.value));
        start = index + keyword.length;
      }
    }

    matches.sort((a, b) => a.start.compareTo(b.start));

    final spans = <TextSpan>[];
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: defaultStyle ?? DefaultTextStyle.of(context).style,
        ));
      }

      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: match.style,
        recognizer: !(onTapMap != null && onTapMap!.containsKey(match.keyword))
            ? null
            : TapGestureRecognizer()
          ?..onTap = () {
            if (onTapMap != null && onTapMap!.containsKey(match.keyword)) {
              onTapMap![match.keyword]!(); // 执行点击回调
            }
          },
      ));

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: defaultStyle ?? DefaultTextStyle.of(context).style,
      ));
    }

    return RichText(text: TextSpan(children: spans));
  }
}

class _Match {
  final int start;
  final int end;
  final String keyword;
  final TextStyle style;

  _Match(this.start, this.end, this.keyword, this.style);
}
