class StockModel {
  final String name;
  final num volumeNormal;
  final num volumeUseable;
  final num marketPrice;
  final num capitalPrice;

  const StockModel({
    this.name = '',
    this.volumeNormal = 0,
    this.volumeUseable = 1,
    this.marketPrice = 1,
    this.capitalPrice = 1,
  });

  /// lấy tổng khối lượng sở hữu
  num get getTotalVolume => volumeUseable;

  /// lấy giá theo vốn sở hữu
  num get getTotalCapitalPrice => getTotalVolume * capitalPrice;

  /// lấy giá theo thị trường
  num get getTotalMarketPrice => getTotalVolume * marketPrice;

  /// lấy số tiền lãi lỗ
  num get getProfitOrLoss => getTotalMarketPrice - getTotalCapitalPrice;

  /// lấy phần trăm lãi lỗ
  num get getPercentProfitOrLoss {
    if (getTotalCapitalPrice == getTotalMarketPrice) {
      return 0;
    }

    return getProfitOrLoss * 100 / getTotalCapitalPrice;
  }
}
