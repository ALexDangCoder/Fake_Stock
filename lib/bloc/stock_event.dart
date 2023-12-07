part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();
}

class CreateOrUpdateStockEvent extends StockEvent {
  final String nameStock;
  final num volumeNormal;
  final num volumeUseable;
  final num marketPrice;
  final num capitalPrice;
  final int? index;

  const CreateOrUpdateStockEvent({
    this.nameStock = '',
    this.volumeNormal = 0,
    this.volumeUseable = 0,
    this.marketPrice = 0,
    this.capitalPrice = 0,
    this.index,
  });

  @override
  List<Object?> get props => [
        nameStock,
        volumeNormal,
        volumeUseable,
        marketPrice,
        capitalPrice,
        index,
      ];
}

class DeleteStockEvent extends StockEvent {
  final int index;

  const DeleteStockEvent({
    required this.index,
  });

  @override
  List<Object?> get props => [
        index,
      ];
}

class HideVolumeEvent extends StockEvent {
  const HideVolumeEvent();

  @override
  List<Object?> get props => [];
}

class HideMoneyEvent extends StockEvent {
  const HideMoneyEvent();

  @override
  List<Object?> get props => [];
}

class ResetAllStockEvent extends StockEvent {
  const ResetAllStockEvent();

  @override
  List<Object?> get props => [];
}
