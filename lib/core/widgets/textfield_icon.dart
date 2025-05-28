import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class IconTextField extends StatelessWidget {
  final IconData iconData;

  const IconTextField({
    super.key,
    required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.orangeColor,width: 2)
      ),
      padding: EdgeInsets.all(10),
      child: Icon(iconData,color: AppColor.orangeColor,),);
  }
}
