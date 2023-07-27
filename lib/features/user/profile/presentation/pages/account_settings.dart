import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/config/themes/dark_theme.dart';
import 'package:bein_ecommerce/config/themes/light_theme.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/settings/presentation/manager/theme_cubit.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../cart/presentation/pages/cart_page.dart';
import '../../../../splash/presentation/localization/local_bloc/local_cubit.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool isChanged = false;

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  AppLocalizations.of(context)?.translate("account") ??
                      "Account",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  focusColor: ColorsManager.lightBlue,
                  leading: Icon(
                    Icons.favorite_border_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    AppLocalizations.of(context)?.translate('fav') ?? "fav",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesScreen()),
                    );
                  },
                ),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: ListTile(
              //     focusColor: ColorsManager.lightBlue,
              //     leading: Icon(
              //       Icons.wallet_outlined,
              //       color: Theme.of(context).iconTheme.color,
              //     ),
              //     title: Text(
              //       AppLocalizations.of(context)?.translate('finance') ??
              //           "finance",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     trailing: Icon(
              //       Icons.arrow_forward_ios,
              //       size: 20,
              //       color: Theme.of(context).iconTheme.color,
              //     ),
              //     onTap: () {},
              //   ),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(
                    color: Theme.of(context).iconTheme.color,
                    Icons.language_outlined,
                  ),
                  title: Text(
                    AppLocalizations.of(context)?.translate('language') ??
                        "language",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () async {
                    AppLocalizations.of(context)!.isEnLocale
                        ? await LocaleCubit.get(context).toArabic()
                        : await LocaleCubit.get(context).toEnglish();
                  },
                  trailing: Icon(
                    Icons.refresh,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  focusColor: ColorsManager.lightBlue,
                  leading: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    AppLocalizations.of(context)?.translate('about_us') ??
                        "about_us",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {},
                ),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.phone_outlined,
              //       color: Theme.of(context).iconTheme.color,
              //     ),
              //     title: Text(
              //         AppLocalizations.of(context)?.translate('contact_us') ??
              //             "contact_us", style: Theme.of(context).textTheme.bodyMedium,),
              //     trailing: Icon(
              //       Icons.arrow_forward_ios,
              //       size: 20,
              //       color: Theme.of(context).iconTheme.color,
              //     ),
              //     onTap: () {
              //       Navigator.pushNamed(context, AppRouteName.contactUs);
              //     },
              //   ),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () async {
                    setState(() async {
                      !isChanged
                          ? BlocProvider.of<ChangeThemeBloc>(context)
                              .add(LightThemeEvent())
                          : BlocProvider.of<ChangeThemeBloc>(context)
                              .add(DarkThemeEvent());

                      isChanged = !isChanged;
                    });
                    await saveThemeMode(
                        !isChanged ? ThemeMode.light : ThemeMode.dark);
                  },
                  child: ListTile(
                    leading: Icon(
                      color: Theme.of(context).iconTheme.color,
                      Icons.dark_mode,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate('dark_mode') ??
                          "dark_mode",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Icon(
                      color: Theme.of(context).iconTheme.color,
                      Icons.brightness_4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
