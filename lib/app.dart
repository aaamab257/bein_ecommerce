import 'package:bein_ecommerce/config/themes/app_theme.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:bein_ecommerce/features/settings/presentation/manager/theme_cubit.dart';
import 'package:bein_ecommerce/features/settings/presentation/manager/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/localization/App_localization_setup.dart';
import 'config/route/app_routes.dart';
import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';
import 'features/splash/presentation/localization/local_bloc/local_cubit.dart';
import 'package:bein_ecommerce/di.dart' as di;

class BeInApp extends StatelessWidget {
  final ThemeMode themeMode;

  const BeInApp({Key? key, required this.themeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => di.sl<LocaleCubit>()..getSavedLang()),
              BlocProvider(
                  create: (context) => BlocProvider.of<CartCubit>(context)),
            ],
            child: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => ChangeThemeBloc(),
                  child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
                    builder: (context, themeState) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        locale: state.local,
                        supportedLocales:
                            AppLocalizationsSetup.supportedLocales,
                        localeResolutionCallback:
                            AppLocalizationsSetup.localeResolutionCallback,
                        localizationsDelegates:
                            AppLocalizationsSetup.localizationsDelegates,
                        title: 'Be In',
                        themeMode: themeMode,
                        theme: themeState.changeTheme,
                        darkTheme: darkTheme,
                        onGenerateRoute: AppRoutes.onGenerateRoute,
                      );
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
