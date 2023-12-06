import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/stock_model.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(const StockState()) {
    /// Sửa hoặc xóa
    on<CreateOrUpdateStockEvent>((event, emit) {
      final newData = StockModel(
        name: event.nameStock,
        capitalPrice: event.capitalPrice,
        marketPrice: event.marketPrice,
        volumeNormal: event.volumeNormal,
        volumeUseable: event.volumeUseable,
      );

      List<StockModel> listData = List.from(state.stocksData);

      if (event.index == null) {
        listData.add(newData);
      } else {
        listData[event.index!] = newData;
      }

      emit(state.copyWith(
        stocksData: listData,
        index: null,
      ));
    });

    /// delete
    on<DeleteStockEvent>((event, emit) {
      List<StockModel> listData = List.from(state.stocksData);

      listData.removeAt(event.index);

      emit(state.copyWith(
        stocksData: listData,
        index: null,
      ));
    });

    /// ẩn khối lượng
    on<HideVolumeEvent>((event, emit) {
      emit(state.copyWith(
        isHideVolume: !state.isHideVolume,
      ));
    });

    /// ẩn lãi lỗ
    on<HideMoneyEvent>((event, emit) {
      emit(state.copyWith(
        isHideMoney: !state.isHideMoney,
      ));
    });
  }
}
