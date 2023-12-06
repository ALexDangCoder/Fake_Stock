import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'bloc/stock_bloc.dart';
import 'model/stock_model.dart';

class EditStockScreen extends StatefulWidget {
  final int? index;

  const EditStockScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  EditStockScreenState createState() => EditStockScreenState();
}

class EditStockScreenState extends State<EditStockScreen> {
  late final StockBloc _stockBloc;
  late final StockModel _stockModel;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController volumeNormalController = TextEditingController();
  final TextEditingController volumeUseableController = TextEditingController();
  final TextEditingController capitalPriceController = TextEditingController();
  final TextEditingController marketPriceController = TextEditingController();

  @override
  void initState() {
    _stockBloc = context.read<StockBloc>();
    _stockModel = _stockBloc.state.getStockModelSelected(widget.index);
    super.initState();
    init();
  }

  @override
  void dispose() {
    nameController.dispose();
    volumeNormalController.dispose();
    volumeUseableController.dispose();
    capitalPriceController.dispose();
    marketPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Chỉnh sửa cổ phiếu')),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nhập Mã cổ phiếu:'),
              TextField(
                controller: nameController,
              ),
              const Text('Nhập khối lượng thường:'),
              TextField(
                controller: volumeNormalController,
              ),
              const Text('Nhập khối lượng khả dụng:'),
              TextField(
                controller: volumeUseableController,
              ),
              const Text('Nhập giá vốn:'),
              TextField(
                controller: capitalPriceController,
              ),
              const Text('Nhập giá thị trường:'),
              TextField(
                controller: marketPriceController,
              ),
              30.verticalSpace,
              Center(
                child: ElevatedButton(
                  child: Text(widget.index == null ? 'Thêm mã' : 'Sửa mã'),
                  onPressed: () {
                    _updateStockData();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void init() {
    nameController.text = _stockModel.name;
    volumeNormalController.text = _stockModel.volumeNormal.toString();
    volumeUseableController.text = _stockModel.volumeUseable.toString();
    capitalPriceController.text = _stockModel.capitalPrice.toString();
    marketPriceController.text = _stockModel.marketPrice.toString();
  }

  void _updateStockData() {
    _stockBloc.add(CreateOrUpdateStockEvent(
      nameStock: nameController.text,
      volumeNormal: num.parse(volumeNormalController.text),
      volumeUseable: num.parse(volumeUseableController.text),
      capitalPrice: num.parse(capitalPriceController.text),
      marketPrice: num.parse(marketPriceController.text),
      index: widget.index,
    ));
  }
}
