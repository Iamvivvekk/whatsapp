import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';

class AppTheme {
  AppTheme._();
// -------------------Light Theme---------------------
  static ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: AppColor.tabColor,
      scaffoldBackgroundColor: AppColor.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.tabColor),

//-------------------APPBAR THEME----------------------
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.appBarColor,
        foregroundColor: AppColor.textColor,
      ),

// -------------FloatingActionButtonTheme---------------

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.appBarColor,
        foregroundColor: AppColor.tabColor,
      ),

// -------------------TEXT THEME------------------------
      textTheme: const TextTheme().copyWith(
        titleLarge: const TextStyle(
          fontSize: 18,
          color: AppColor.textColor,
        ),
        bodyMedium: const TextStyle(
          color: AppColor.textColor,
          fontSize: 14,
        ),
        bodySmall: const TextStyle(
          color: AppColor.textColor,
          fontSize: 12,
        ),
      ),
// --------------------IconButton theme ----------------

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.greyColor,
          iconSize: 22,
        ),
      ),
    );
  }
}
