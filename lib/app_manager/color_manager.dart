import 'package:flutter/material.dart';

class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const blue = Colors.blue;
  static const Color color808088 = Color(0xFF808088);
  static const Color color28272c = Color(0xFF28272c);
  static const Color color00A95B = Color(0xFF00A95B);
  static const Color colorCc4951 = Color(0xFFcc4951);
  static const Color color89242a = Color(0xFF89242a);
  static const Color color7f8085 = Color(0xFF7f8085);
  static const Color colorC4c4cc = Color(0xFFc4c4cc);
  static const Color colorF5f4f9 = Color(0xFFf5f4f9);
  static const Color colorD14140 = Color(0xFFd14140);
  static const Color colorD5d4d9 = Color(0xFFd5d4d9);
  static const Color colorEbebed = Color(0xFFebebed);
  static const Color color818183 = Color(0xFF818183);
  static const Color colorBbbbbb = Color(0xFFbbbbbb);
  static const Color colorBd4739 = Color(0xFFbd4739);
  static const Color colorD34141 = Color(0xFFd34141);
  static const Color color747474 = Color(0xFF747474);
  static const Color colorC3c1cc = Color(0xFFc3c1cc);
  static const Color colorDfdee3 = Color(0xFFdfdee3);

  static Color getColorMoney(num number, {Color? colorZero}) {
    if (number < 0) {
      return colorCc4951;
    }

    if (number > 0) {
      return color00A95B;
    }
    return colorZero ?? black;
  }
}
