import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? fontFamily;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
    this.fontStyle,
    this.overflow,
    this.maxLines,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow:TextOverflow.ellipsis,
      maxLines: maxLines??2,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
        fontStyle: fontStyle,
      ),
    );
  }
}
