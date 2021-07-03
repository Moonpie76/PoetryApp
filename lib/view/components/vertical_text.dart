import 'package:flutter/material.dart';

// text aligns vertically, from top to bottom and right to left.
//
// 垂直布局的文字. 从右上开始排序到左下角.
class VerticalText extends CustomPainter {
  late String text;
  late double width;
  late double height;
  late TextStyle textStyle;
  late double y;

  VerticalText(
      {required String text,
      required TextStyle textStyle,
      required double width,
      required double height,
      required double y}) {
    this.width = width;
    this.height = height;
    this.text = text;
    this.textStyle = textStyle;
    this.y = y;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = textStyle.color! as Color;
    double offsetX = width;
    double offsetY = y;
    bool newLine = false;
    double maxWidth = 0;

    maxWidth = findMaxWidth(text, textStyle);

    for (int i = 0; i < text.length; i++) {
      var str = text[i];
      if(str == '，' ||
          str == '。' ||
          str == '、' ||
          str == '；' ||
          str == '！' ||
          str == '？' ||
          str == '：') {
        str = '';
      }
      if (i != 0) {
        var lastStr = text[i - 1];
        if (lastStr == '，' ||
            lastStr == '。' ||
            lastStr == '、' ||
            lastStr == '；' ||
            lastStr == '！' ||
            lastStr == '？' ||
            lastStr == '：') {
          newLine = true;
          offsetY = y;
        }
      }
      TextSpan span = new TextSpan(style: textStyle, text: str);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();

      if (offsetY + tp.height > height) {
        newLine = true;
        offsetY = y;
      }

      if (newLine) {
        offsetX -= maxWidth;
        newLine = false;
      }

      if (offsetX < -maxWidth) {
        return;
      }

      tp.paint(canvas, new Offset(offsetX, offsetY));
      offsetY += tp.height;


    }

  }

  double findMaxWidth(String text, TextStyle style) {
    double maxWidth = 0;

    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: style, text: str);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      maxWidth = max(maxWidth, tp.width);
    });

    return maxWidth;
  }

  @override
  bool shouldRepaint(VerticalText oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.width != width ||
        oldDelegate.height != height;
  }

  double max(double a, double b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  }
}
