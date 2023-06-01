import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_string/app_constant.dart';
import '../../core/utils/colors/colors_manager.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: ColorsManager.orange,
      hintColor: ColorsManager.grey,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorsManager.background,
      fontFamily: AppConstants.fontFamily,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          centerTitle: true,
          elevation: 0,
          color: Colors.transparent,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20)),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => ColorsManager.black)
        ),
      ),

      textTheme:  TextTheme(
        bodyMedium: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400),
        titleLarge:  TextStyle(
            fontSize: 16.sp,
            color: ColorsManager.black,
            fontWeight: FontWeight.w500),
        titleMedium:  TextStyle(
            fontSize: 18.sp,
            color: ColorsManager.black,
            fontWeight: FontWeight.w500),
        displaySmall:  TextStyle(
            fontSize: 18.sp,
            ),

      )

  );
}