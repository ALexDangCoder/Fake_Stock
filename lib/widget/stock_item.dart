import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/app_manager/num_extnsion.dart';
import 'package:smartOne/widget/stock_widget.dart';
import 'package:smartOne/widget/stock_widget_2.dart';
import 'package:smartOne/widget/stock_widget_3.dart';

import '../app_manager/color_manager.dart';
import '../bloc/stock_bloc.dart';
import '../edit_stock_screen.dart';
import '../model/stock_model.dart';
import 'button_widget.dart';
import 'finance_widget.dart';

class StockItem extends StatefulWidget {
  final StockModel stockModel;
  final int index;

  const StockItem({
    super.key,
    required this.stockModel,
    required this.index,
  });

  @override
  State<StockItem> createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
  bool _isHide = false;
  late final StockBloc _stockBloc;
  StockModel _stockModel = const StockModel();

  @override
  void initState() {
    _stockBloc = context.read<StockBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _stockModel = widget.stockModel;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isHide = !_isHide;
              });
            },

            /// Header
            child: BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 11.5.h, horizontal: 15.w),
                  child: Row(
                    children: <Widget>[
                      ///mã cp
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            _textHeader(
                              _stockModel.name,
                              color: AppColors.getColorMoney(
                                  _stockModel.getPercentProfitOrLoss),
                              fontWeight: FontWeight.w700,
                            ),
                            Icon(
                              _isHide
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 12.r,
                              color: AppColors.color747474,
                            )
                          ],
                        ),
                      ),

                      ///giá vốn
                      Expanded(
                        flex: 3,
                        child: _textHeader(
                          state.isHideMoney
                              ? '***'
                              : (_stockModel.capitalPrice / 1000)
                                  .toFormatWithCommas(
                                  isShowFullCent: true,
                                ),
                          textAlign: TextAlign.right,
                        ),
                      ),

                      ///giá tt
                      Expanded(
                        flex: 3,
                        child: _textHeader(
                          (_stockModel.marketPrice / 1000)
                              .toFormatWithCommas(isShowFullCent: true),
                          textAlign: TextAlign.right,
                        ),
                      ),

                      ///kl
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30.w),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _textHeader(state.isHideVolume
                                ? '***'
                                : _stockModel.getTotalVolume
                                    .toFormatWithCommas()),
                          ),
                        ),
                      ),

                      ///lãi/lỗ
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: state.isHideMoney
                              ? _textHeader('***')
                              : Container(
                                  width: 120.w,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.getColorMoney(
                                      _stockModel.getPercentProfitOrLoss,
                                      colorZero: AppColors.colorC3c1cc,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6.5.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        moneyWithPlus(
                                            _stockModel.getPercentProfitOrLoss,
                                            _stockModel.getPercentProfitOrLoss
                                                .toFormatWithCommas(
                                                    isShowFullCent: true)),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.02,
                                        ),
                                      ),
                                      0.5.horizontalSpace,
                                      Image.asset(
                                        'assets/icon_percent.png',
                                        color: Colors.white,
                                        height: 7.3.sp,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// content
          Visibility(
            visible: _isHide,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// tổng quan
                contentTop(),
                10.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// left,
                    contentLeft(),
                    7.horizontalSpace,

                    ///right
                    contentRight()
                  ],
                ),
                5.verticalSpace,

                /// bottom button
                bottomButton(),
                8.verticalSpace,
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bottomButton() => Row(
        children: [
          Expanded(
            child: buttonWidget(
              title: 'Mua',
              color: AppColors.color00A95B,
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  _stockBloc.add(DeleteStockEvent(index: widget.index)),
              child: buttonWidget(
                title: 'Bán',
                color: AppColors.colorD34141,
              ),
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditStockScreen(index: widget.index),
                  ),
                );
              },
              child: buttonWidget(
                title: 'Thông tin mã',
                color: AppColors.color747474,
              ),
            ),
          ),
        ],
      );

  Widget contentTop() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: FinanceWidget(
          totalCapital: _stockModel.getTotalCapitalPrice,
          marketValue: _stockModel.getTotalMarketPrice,
          profitOrLoss: _stockModel.getProfitOrLoss,
        ),
      );

  Widget contentLeft() => StockWidget(
        totalAmount: _stockModel.getTotalVolume.toFormatWithCommas(),
        regularAmount: _stockModel.volumeUseable.toFormatWithCommas(),
        fsAmount: '0',
        availableAmount: _stockModel.volumeUseable.toFormatWithCommas(),
        outroomAmount: '0',
      );

  Widget contentRight() => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          StockWidget2(
            totalAmount: '0',
            regularAmount: '0',
          ),
          7.verticalSpace,
          StockWidget3(
            totalT0: '0',
            totalT1: '0',
            totalT2: '0',
          ),
        ],
      );

  Widget _textHeader(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) =>
      Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: 13.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
        textAlign: textAlign,
      );
}

Widget buildRowWidget(
  String title,
  BuildContext context,
  String value, {
  String? icon,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 11.sp,
          color: AppColors.color818183,
        ),
      ),
      7.horizontalSpace,
      if (icon != null)
        Image.asset(
          icon,
          height: 12.r,
          color: AppColors.color818183,
        ),
      const Spacer(),
      Text(
        context.read<StockBloc>().state.isHideVolume ? '***' : value,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

String moneyWithPlus(num data, String defaultData) {
  if (data > 0) {
    return '+$defaultData';
  }

  return defaultData;
}
