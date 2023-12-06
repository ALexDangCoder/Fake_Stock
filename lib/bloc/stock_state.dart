part of 'stock_bloc.dart';

class StockState extends Equatable {
  final List<StockModel> stocksData;
  final int? index;
  final bool isHideVolume;
  final bool isHideMoney;

  const StockState({
    this.stocksData = const [],
    this.index,
    this.isHideVolume = false,
    this.isHideMoney = false,
  });

  @override
  List<Object?> get props => [
        stocksData,
        index,
        isHideVolume,
        isHideMoney,
      ];

  /// tổng tiền theo khối lượng tất cả cổ phiếu đang sở hữu
  num get getTotalCapitalPriceStocks {
    if (stocksData.isEmpty) {
      return 0;
    }

    return stocksData
        .map((e) => e.getTotalCapitalPrice)
        .reduce((a, b) => a + b);
  }

  /// tổng theo khối lượng tất cả cổ phiếu đang sở hữu với giá thị trường
  num get getTotalMarketPriceStocks {
    if (stocksData.isEmpty) {
      return 0;
    }

    return stocksData.map((e) => e.getTotalMarketPrice).reduce((a, b) => a + b);
  }

  /// tổng tiền lãi lỗ tất cả cổ phiếu
  num get getProfitOrLossStocks {
    if (stocksData.isEmpty) {
      return 0;
    }

    return stocksData.map((e) => e.getProfitOrLoss).reduce((a, b) => a + b);
  }

  /// tổng % tiền lãi lỗ tất cả cổ phiếu
  num get getPercentProfitOrLossStocks {
    if (stocksData.isEmpty ||
        getTotalCapitalPriceStocks == getTotalMarketPriceStocks) {
      return 0;
    }

    return getProfitOrLossStocks * 100 / getTotalCapitalPriceStocks;
  }

  /// lấy stock đang sở chọn để sửa
  StockModel getStockModelSelected(int? index) {
    if (stocksData.isEmpty || index == null) {
      return const StockModel();
    }

    return stocksData[index];
  }

  StockState copyWith({
    List<StockModel>? stocksData,
    int? index,
    bool? isHideVolume,
    bool? isHideMoney,
  }) {
    return StockState(
      stocksData: stocksData ?? this.stocksData,
      index: index ?? this.index,
      isHideVolume: isHideVolume ?? this.isHideVolume,
      isHideMoney: isHideMoney ?? this.isHideMoney,
    );
  }
}
