import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_manager/color_manager.dart';

Widget cartBorderWidget({
  required Widget child,
  double border = 4,
}) =>
    Container(
      decoration: BoxDecoration(
        color: AppColors.colorF5f4f9,
        borderRadius: BorderRadius.all(
          Radius.circular(border.r),
        ),
      ),
      child: child,
    );
