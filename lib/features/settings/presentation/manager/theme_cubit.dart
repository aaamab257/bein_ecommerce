import 'package:bein_ecommerce/config/themes/dark_theme.dart';
import 'package:bein_ecommerce/config/themes/light_theme.dart';
import 'package:bein_ecommerce/features/settings/presentation/manager/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomMaterialColor {
  final int r;
  final int g;
  final int b;

  CustomMaterialColor(this.r, this.g, this.b);

  MaterialColor get mdColor {
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    return MaterialColor(Color.fromRGBO(r, g, b, 1).value, color);
  }
}

abstract class ThemeEvent {
  ThemeData getTheme();

  String getName();
}

class DarkThemeEvent extends ThemeEvent {
  final ThemeData themeData = darkTheme;

  @override
  String getName() {
    return "dark";
  }

  @override
  ThemeData getTheme() {
    return themeData;
  }
}

class LightThemeEvent extends ThemeEvent {
  final ThemeData themeData = lightTheme;



  @override
  String getName() {
    return "light";
  }

  @override
  ThemeData getTheme() {
    return themeData;
  }
}

class ChangeThemeBloc extends Bloc<ThemeEvent, ChangeThemeState> {
  ChangeThemeBloc() : super(ChangeThemeState("initial", lightTheme)) {
    on<DarkThemeEvent>((event, emit) =>
        emit(ChangeThemeState(event.getName(), event.getTheme())));
    on<LightThemeEvent>((event, emit) =>
        emit(ChangeThemeState(event.getName(), event.getTheme())));
  }


}
