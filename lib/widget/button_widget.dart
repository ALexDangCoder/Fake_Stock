import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buttonWidget({
  required String title,
  Color color = Colors.grey,
  EdgeInsets? padding,
}) =>
    Container(
      height: 22.h,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        border: Border.all(
          color: color,
        ),
      ),
      child: Center(
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
