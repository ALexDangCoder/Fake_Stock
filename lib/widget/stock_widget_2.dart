import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/widget/stock_item.dart';

import 'cart_border_widget.dart';

class StockWidget2 extends StatelessWidget {
  final String totalAmount;
  final String regularAmount;

  const StockWidget2({
    Key? key,
    required this.totalAmount,
    required this.regularAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cartBorderWidget(
      child: Container(
        padding: EdgeInsets.all(5.r).copyWith(left: 6.w, right: 6.w),
        width: MediaQuery.of(context).size.width * 0.5 - (11.5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRowWidget(
              'KL khác',
              context,
              totalAmount,
              icon: 'assets/warning.png',
            ),
            3.verticalSpace,
            buildRowWidget(
              'CPCT/Thưởng',
              context,
              regularAmount,
            ),
          ],
        ),
      ),
    );
  }
}
