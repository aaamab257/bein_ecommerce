import 'package:flutter/material.dart';

import '../../core/utils/colors/colors_manager.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffF8F9FE),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffF8F9FE),
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff88489E),
        fontFamily: 'Cairo'),
    iconTheme: IconThemeData(
      color: Color(0xffA5CD39),
    ),
  ),
  accentColor: const Color(0xff6A2A80),
  primaryColor: const Color(0xffE8E9EE),
  primaryColorLight: Colors.white,
  primaryColorDark: const Color(0xffA5CD39),
  dividerTheme: const DividerThemeData(
    color: Color(0xffE0E3EA),
    thickness: 4.0,
    indent: 16.0,
    endIndent: 16.0,
  ),
  switchTheme: SwitchThemeData(
    // Customize the colors
    splashRadius: 50,
    thumbColor: MaterialStateProperty.all(const Color(0xffA5CD39)),
    trackColor: MaterialStateProperty.all(Colors.grey),
    overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.5)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xff88489E),
    foregroundColor: Color(0xffA5CD39),
    elevation: 4.0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff88489E),
    selectedItemColor: Color(0xffA5CD39),
    unselectedItemColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.normal, fontFamily: 'Cairo'),
    headlineMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
      color: Color(0xff88489E),
    ),
    headlineSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Color(0xff88489E),
        fontFamily: 'Cairo'),
    bodyLarge:
        TextStyle(fontSize: 22.0, color: Colors.white, fontFamily: 'Cairo'),
    bodyMedium: TextStyle(
      fontSize: 18.0,
      color: Color(0xff88489E),
      fontFamily: 'Cairo',
    ),
    bodySmall: TextStyle(
        fontSize: 14.0, color: Color(0xffFFFFFF), fontFamily: 'Cairo'),
  ),
  cardTheme: CardTheme(
    color: const Color(0xffFFFFFF),
    elevation: 2.0,
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 24.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    hintStyle: TextStyle(color: Colors.grey[400], fontFamily: 'Cairo'),
    errorStyle: TextStyle(color: Colors.red[400], fontFamily: 'Cairo'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xff88489E)),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 18,
          color: ColorsManager.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xffA5CD39), // The color of the icons.
    opacity: 0.8, // The opacity of the icons.
    size: 20,
    // The size of the icons.
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(double.infinity, 50.0),
      ),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xff6D2D83)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo'),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      elevation: MaterialStateProperty.all<double>(4.0),
    ),
  ),
); /**/
