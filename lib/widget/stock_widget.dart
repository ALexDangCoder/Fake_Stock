import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/widget/stock_item.dart';

import 'cart_border_widget.dart';

class StockWidget extends StatelessWidget {
  final String totalAmount;
  final String regularAmount;
  final String fsAmount;
  final String availableAmount;
  final String outroomAmount;

  const StockWidget({
    Key? key,
    required this.totalAmount,
    required this.regularAmount,
    required this.fsAmount,
    required this.availableAmount,
    required this.outroomAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cartBorderWidget(
      child: Container(
        padding: EdgeInsets.all(5.r).copyWith(left: 6.w, right: 6.w),
        width: MediaQuery.of(context).size.width * 0.5 - (15.w + 7.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRowWidget('Tổng KL', context, totalAmount),
            paddingRow(),
            buildRowWidget('KL thường', context, regularAmount),
            paddingRow(),
            buildRowWidget('KL FS', context, fsAmount),
            paddingRow(),
            buildRowWidget('KL khả dụng', context, availableAmount),
            paddingRow(),
            buildRowWidget('Outroom', context, outroomAmount),
            paddingRow()
          ],
        ),
      ),
    );
  }

  Widget paddingRow() => 9.5.verticalSpace;
}
