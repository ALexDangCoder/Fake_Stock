import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartOne/widget/stock_item.dart';

import '../app_manager/color_manager.dart';
import '../bloc/stock_bloc.dart';
import 'button_widget.dart';
import 'investment_summary_widget.dart';

class FullContentPageWidget extends StatefulWidget {
  const FullContentPageWidget({super.key});

  @override
  State<FullContentPageWidget> createState() => _FullContentPageWidgetState();
}

class _FullContentPageWidgetState extends State<FullContentPageWidget> {
  late final StockBloc _stockBloc;

  @override
  void initState() {
    _stockBloc = context.read<StockBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 25.5.h,
              child: Image.asset('assets/banner_hot.jpg'),
            ),
            9.verticalSpace,
            bringWidget(),
            11.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Danh mục nắm giữ
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        'Danh mục nắm giữ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    13.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: InvestmentSummaryWidget(
                        /// lãi lỗ danh mục
                        portfolioChange: state.getProfitOrLossStocks.toDouble(),

                        /// % lãi lỗ danh mục
                        portfolioChangePercent:
                            state.getPercentProfitOrLossStocks.toDouble(),

                        /// lãi lỗ hôm nay
                        todayChange: 0,

                        /// tổng vốn
                        totalCapital:
                            state.getTotalCapitalPriceStocks.toDouble(),

                        /// tổng giá trị thị trường
                        marketValue: state.getTotalMarketPriceStocks.toDouble(),
                      ),
                    ),
                    12.verticalSpace,

                    /// ẩn khối lượng
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: GestureDetector(
                        onTap: () {
                          _stockBloc.add(const HideVolumeEvent());
                        },
                        child: ColoredBox(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              state.isHideVolume
                                  ? Image.asset(
                                      'assets/check_box_active.png',
                                      height: 15.r,
                                      width: 15.r,
                                    )
                                  : Container(
                                      height: 15.r,
                                      width: 15.r,
                                      decoration: BoxDecoration(
                                          color: AppColors.colorF5f4f9,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3.r),
                                          ),
                                          border: Border.all(
                                              color: AppColors.colorDfdee3)),
                                    ),
                              8.horizontalSpace,
                              Text(
                                'Ẩn khối lượng',
                                style: TextStyle(
                                  fontSize: 13.5.sp,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _stockBloc.add(const ResetAllStockEvent());
                                },
                                child: buttonWidget(
                                  title: 'Bán nhiều mã',
                                  color: AppColors.color89242a,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 22.w),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// listStock

                    if (state.stocksData.isNotEmpty) ...[
                      15.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: AppColors.colorBbbbbb,
                          width: 0.5.h,
                        ))),
                        padding: EdgeInsets.symmetric(horizontal: 15.w)
                            .copyWith(bottom: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: _getTextStockTitle('MÃ CP',
                                    textStyle: TextStyle(
                                        fontSize: 11.sp,
                                        color: AppColors.color818183,
                                        fontWeight: FontWeight.w600))),
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: _getTextStockTitle('GIÁ VỐN'),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: _getTextStockTitle('GIÁ TT'))),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _getTextStockTitle('KL'),
                                    5.horizontalSpace,
                                    Image.asset(
                                      'assets/up_down.png',
                                      width: 6.r,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Center(
                                    child: _getTextStockTitle('LÃI/LỖ'))),
                          ],
                        ),
                      ),
                      ...List.generate(
                        state.stocksData.length,
                        (index) {
                          final data = state.stocksData[index];

                          return StockItem(
                            stockModel: data,
                            index: index,
                          );
                        },
                      ),
                      15.verticalSpace,
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getTextStockTitle(String text, {TextStyle? textStyle}) => Text(
        text,
        style: textStyle ??
            TextStyle(
              fontSize: 11.sp,
              color: AppColors.color818183,
            ),
      );

  Widget bringWidget() => Center(
        child: Container(
          height: 5.h,
          width: 45.w,
          decoration: BoxDecoration(
            color: AppColors.colorC4c4cc,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
        ),
      );
}
