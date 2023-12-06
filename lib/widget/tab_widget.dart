import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_manager/color_manager.dart';

class TabWidget extends StatefulWidget {
  final bool isSelected;

  const TabWidget({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  @override
  TabWidgetState createState() => TabWidgetState();
}

class TabWidgetState extends State<TabWidget> {
  TextEditingController textField1Controller =
      TextEditingController(text: '762663');
  TextEditingController textField2Controller = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showDialog(
        context,
        textEditingController: textField1Controller,
        textEditingController2: textField2Controller,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textField1Controller.text,
            style: TextStyle(
              fontSize: 11.sp,
              color: widget.isSelected
                  ? AppColors.color28272c
                  : AppColors.color7f8085,
            ),
          ),
          1.5.horizontalSpace,
          Container(
            height: 15.5.r,
            width: 15.5.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.isSelected
                  ? AppColors.color89242a
                  : AppColors.color7f8085,
            ),
            child: Center(
              child: Text(
                textField2Controller.text,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(
    BuildContext context, {
    required TextEditingController textEditingController,
    required TextEditingController textEditingController2,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,
              ),
              TextField(
                controller: textEditingController2,
              ),
              16.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    textField1Controller = textEditingController;
                    textField2Controller = textEditingController2;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
