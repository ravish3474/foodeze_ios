import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFFa6cb45);
const Color colorSecondPrimary = Color(0xFF8DA64A);
const Color colorprimary2 = Color(0xFFCCDF94);
const Color colorPrimaryLight = Color(0xFF8DA64A);
const Color colorAccent = Color(0xFF019AD8);
const Color lightAccentColor = Color(0xFFa3cdf3);
const Color textColor = Color(0xff292929);
const Color dividerColor = Colors.white38;
const Color colorScafoldBackground = const Color(0xfff7f8fb);
const Color chipColor = Color(0xFFdbe3ee);
const Color lightWhite = Color(0xFFf5f3f0);
const Color colorWhite = Colors.white;
const Color hintColor = Colors.black26;
const Color colorGrey = Colors.grey;
const Color lightGrey = Color(0xFFdcdcdc);
const Color boarderGrey = Color(0xFFC2C2C2);
const Color whiteTransparent = Colors.white54;
const Color lightTextColor = Colors.white70;

const Color color1 = Color(0xFF10B310);
const Color color2 = Color(0xFFFF5722);

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5!.copyWith(color: colorPrimary));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme), primaryColor: colorPrimary);
}
