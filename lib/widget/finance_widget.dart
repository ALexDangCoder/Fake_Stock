import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/app_manager/num_extnsion.dart';
import 'package:smartOne/widget/stock_item.dart';

import '../app_manager/color_manager.dart';
import '../bloc/stock_bloc.dart';
import 'cart_border_widget.dart';

class FinanceWidget extends StatelessWidget {
  final num totalCapital;
  final num marketValue;
  final num profitOrLoss;

  const FinanceWidget({
    super.key,
    required this.totalCapital,
    required this.marketValue,
    required this.profitOrLoss,
  });

  @override
  Widget build(BuildContext context) {
    bool isHide = context.read<StockBloc>().state.isHideMoney;

    return cartBorderWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildColumn(
            'Tổng vốn',
            totalCapital,
            isHide: isHide,
          ),
          buildColumn(
            'Giá trị thị trường',
            marketValue,
            isHide: isHide,
          ),
          buildColumn(
            'Lãi / Lỗ',
            profitOrLoss,
            isHide: isHide,
            isBlackOnly: false,
          ),
        ],
      ),
    );
  }

  Widget buildColumn(
    String title,
    num value, {
    bool isHide = false,
    bool isBlackOnly = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.color818183,
            ),
          ),
          4.verticalSpace,
          Text(
            isHide
                ? '***'
                : (isBlackOnly
                    ? value.toFormatWithCommas()
                    : moneyWithPlus(value, value.toFormatWithCommas())),
            style: TextStyle(
              color: (isHide || isBlackOnly)
                  ? Colors.black
                  : AppColors.getColorMoney(value),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
