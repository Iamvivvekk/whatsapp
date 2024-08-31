import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/core/constants/colors.dart';

class AppTheme {
  AppTheme._();
// -------------------Light Theme---------------------
  static ThemeData lightTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
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
        titleLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontSize: 18,
            color: AppColor.textColor,
          ),
        ),
        bodyLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontSize: 24,
            color: AppColor.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),

        //body medium is used for textfield
        bodyMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: AppColor.textColor,
            fontSize: 14,
          ),
        ),
        bodySmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: AppColor.textColor,
            fontSize: 12,
          ),
        ),
      ),
// --------------------IconButton theme ----------------

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.greyColor,
          iconSize: 22,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: Color.fromARGB(170, 158, 158, 158),
          fontSize: 14,
        ),
      ),
    );
  }
}
