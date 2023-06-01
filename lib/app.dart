import 'package:bein_ecommerce/config/themes/app_theme.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/localization/App_localization_setup.dart';
import 'config/route/app_routes.dart';
import 'features/splash/presentation/localization/local_bloc/local_cubit.dart';
import 'package:bein_ecommerce/di.dart' as di;

class BeInApp extends StatelessWidget {
  const BeInApp({Key? key}) : super(key: key);

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
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: state.local,
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                  localizationsDelegates:
                      AppLocalizationsSetup.localizationsDelegates,
                  title: 'Be In',
                  theme: appTheme(),
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                );
              },
            ),
          );
        });
  }
}
