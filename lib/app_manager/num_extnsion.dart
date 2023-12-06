import 'dart:math';

import 'package:intl/intl.dart';

extension NumEx on num {
  String toFormatWithCommas(
      {int decimalPlaces = 2, bool isShowFullCent = false}) {
    num roundedValue =
        (this * pow(10, decimalPlaces)).round() / pow(10, decimalPlaces);

    NumberFormat format = NumberFormat.decimalPattern();
    format.minimumFractionDigits = isShowFullCent ? decimalPlaces : 0;
    format.maximumFractionDigits = decimalPlaces;

    return format.format(roundedValue);
  }
}

///double
extension DoubleEx on double {
  String formatWithCommas(
      {int decimalPlaces = 2, bool isShowFullCent = false}) {
    num roundedValue =
        (this * pow(10, decimalPlaces)).round() / pow(10, decimalPlaces);

    NumberFormat format = NumberFormat.decimalPattern();
    format.minimumFractionDigits = isShowFullCent ? decimalPlaces : 0;
    format.maximumFractionDigits = decimalPlaces;

    return format.format(roundedValue);
  }
}
