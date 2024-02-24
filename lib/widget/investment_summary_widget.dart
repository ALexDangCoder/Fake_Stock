import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/app_manager/num_extnsion.dart';
import 'package:smartOne/widget/stock_item.dart';

import '../app_manager/color_manager.dart';
import '../bloc/stock_bloc.dart';
import 'cart_border_widget.dart';

class InvestmentSummaryWidget extends StatefulWidget {
  final double portfolioChange;
  final double portfolioChangePercent;
  final double todayChange;
  final double totalCapital;
  final double marketValue;

  const InvestmentSummaryWidget({
    Key? key,
    required this.portfolioChange,
    required this.portfolioChangePercent,
    required this.todayChange,
    required this.totalCapital,
    required this.marketValue,
  }) : super(key: key);

  @override
  InvestmentSummaryWidgetState createState() => InvestmentSummaryWidgetState();
}

class InvestmentSummaryWidgetState extends State<InvestmentSummaryWidget> {
  double _editedTodayChange = 0;
  late final StockBloc _stockBloc;

  @override
  void initState() {
    _stockBloc = context.read<StockBloc>();
    super.initState();
    _editedTodayChange = widget.todayChange;
  }

  @override
  Widget build(BuildContext context) {
    return cartBorderWidget(
      border: 13.r,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                _stockBloc.add(const HideMoneyEvent());
              },
              child: _buildSummaryRow(
                "Lãi lỗ danh mục",
                widget.portfolioChange,
                icon: _stockBloc.state.isHideMoney
                    ? 'assets/icon_active_eya.png'
                    : 'assets/un_active_eya.png',
                isHadPlus: true,
              ),
            ),
            if (!_stockBloc.state.isHideMoney) 4.verticalSpace,

            /// phần trăm lãi lỗ tổng danh mục
            if (!_stockBloc.state.isHideMoney) portfolioChangePercentWidget(),
            8.verticalSpace,
            DottedLine(
              dashColor: AppColors.colorD5d4d9,
              dashLength: 5.w,
              dashGapLength: 5.w,
              dashGapRadius: 4.r,
              lineThickness: 0.5.h,
            ),
            8.verticalSpace,
            _buildSummaryRow(
              "Lãi/Lỗ hôm nay",
              _editedTodayChange,
              icon: 'assets/warning.png',
              isHadPlus: true,
            ),
            9.verticalSpace,
            _buildSummaryRow(
              "Tổng vốn",
              widget.totalCapital,
              icon: 'assets/warning.png',
              isTextBlack: true,
            ),
            9.verticalSpace,
            _buildSummaryRow(
              "Tổng giá trị thị trường",
              widget.marketValue,
              isTextBlack: true,
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPopup(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: _editedTodayChange.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Value"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter a value"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                double newValue =
                    double.tryParse(controller.text) ?? widget.todayChange;
                setState(() {
                  _editedTodayChange = newValue;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget portfolioChangePercentWidget() {
    Color color = AppColors.getColorMoney(widget.portfolioChangePercent,
        colorZero: AppColors.colorC3c1cc);

    Color textColor = AppColors.getColorMoney(widget.portfolioChangePercent);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(color: color),
        color: color.withOpacity(0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            moneyWithPlus(widget.portfolioChangePercent,
                widget.portfolioChangePercent.formatWithCommas()),
            style: TextStyle(
              color: textColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          2.horizontalSpace,
          Image.asset(
            'assets/icon_percent.png',
            color: textColor,
            height: 8.2.sp,
          ),
          2.horizontalSpace,
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    double value, {
    bool isTextBlack = false,
    bool isHadPlus = false,
    String? icon,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.color28272c,
            fontSize: 11.5.sp,
          ),
        ),
        if (icon != null) ...[
          6.horizontalSpace,
          Image.asset(
            icon,
            height: 15.r,
            width: 15.r,
          ),
        ],
        const Spacer(),
        GestureDetector(
          onLongPress: () {
            _showEditPopup(context);
          },
          child: Text(
            _stockBloc.state.isHideMoney
                ? '***'
                : isHadPlus
                    ? moneyWithPlus(value, value.formatWithCommas())
                    : value.formatWithCommas(),
            style: TextStyle(
              color: _stockBloc.state.isHideMoney || isTextBlack
                  ? AppColors.color28272c
                  : AppColors.getColorMoney(value),
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
