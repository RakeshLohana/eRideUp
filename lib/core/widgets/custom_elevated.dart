import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';



class CustomElevatedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double borderRadius;
  final double elevation;
  final double horizontalPadding;
  final double verticalPadding;
  final double width;
  final double height;
  final double? textSize;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColor.appPrimaryColor,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.elevation = 5.0,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.width=double.infinity,
    this.fontFamily="",
    this.height=50,
    this.textSize,
    this.fontWeight=FontWeight.w400,
    this.iconColor=AppColor.white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width ,
      height:height ,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,

          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        ),
        child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: textSize ?? 14.sp,
                fontWeight: fontWeight,
                fontFamily: fontFamily,
                color: textColor,
              ),
            ),
          ),
          if (icon != null)
            Positioned(
              right: 16.w, // Adjust padding as needed
              child: Icon(icon, color: iconColor),
            ),
        ],
      ),

    ),
    );
  }
}
