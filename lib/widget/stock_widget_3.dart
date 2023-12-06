import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/widget/stock_item.dart';

import 'cart_border_widget.dart';

class StockWidget3 extends StatelessWidget {
  final String totalT0;
  final String totalT1;
  final String totalT2;

  const StockWidget3({
    Key? key,
    required this.totalT0,
    required this.totalT1,
    required this.totalT2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cartBorderWidget(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
        ).copyWith(left: 6.w, right: 6.w),
        width: MediaQuery.of(context).size.width * 0.5 - (11.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KL mua chờ về',
              style: TextStyle(
                color: Colors.black,
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.01.sp,
              ),
            ),
            5.verticalSpace,
            buildRowWidget('KL T0', context, totalT0),
            5.verticalSpace,
            buildRowWidget('KL T1', context, totalT1),
            5.verticalSpace,
            buildRowWidget('KL T2', context, totalT2),
          ],
        ),
      ),
    );
  }
}
