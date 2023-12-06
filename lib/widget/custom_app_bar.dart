import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_manager/color_manager.dart';
import '../edit_stock_screen.dart';

PreferredSizeWidget customAppBar(
  BuildContext context, {
  required TabBar bottom,
}) =>
    AppBar(
      toolbarHeight: 33.h,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(35.h),
        child: SizedBox(
          height: 35.h,
          child: bottom,
        ),
      ),
      leading: Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.black,
        size: 20.r,
      ),
      title: Text(
        'Cổ phiếu',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 17.sp,
        ),
      ),
      actions: <Widget>[
        Image.asset(
          'assets/icon_search.png',
          width: 18.r,
          color: AppColors.black,
        ),
        15.horizontalSpace,
        IconButton(
          icon: Image.asset(
            'assets/icon_menu.png',
            height: 13.r,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditStockScreen(),
              ),
            );
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0.1.h,
    );
