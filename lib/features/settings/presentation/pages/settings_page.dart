import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/settings/presentation/manager/theme_cubit.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../splash/presentation/localization/local_bloc/local_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isChanged = false;

  _lightTheme(context) {
    BlocProvider.of<ChangeThemeBloc>(context).add(LightThemeEvent());
  }

  _darckTheme(context) {
    BlocProvider.of<ChangeThemeBloc>(context).add(DarkThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0 , vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate("settings") ??
                      "Settings",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.language_outlined,
                    ),
                    title: Text(
                        AppLocalizations.of(context)?.translate('language') ??
                            "language"),
                    onTap: () async {
                      /*setState(() {

                    });*/

                      AppLocalizations.of(context)!.isEnLocale
                          ? await LocaleCubit.get(context).toArabic()
                          : await LocaleCubit.get(context).toEnglish();
                    },
                    trailing: const Icon(
                      Icons.refresh,
                      color: ColorsManager.settingsIconsColor,
                      size: 20,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    focusColor: ColorsManager.lightBlue,
                    leading: const Icon(
                      Icons.info_outline,
                    ),
                    title: Text(
                        AppLocalizations.of(context)?.translate('about_us') ??
                            "about_us"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                          )),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone_outlined,

                    ),
                    title: Text(
                        AppLocalizations.of(context)?.translate('contact_us') ??
                            "contact_us"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorsManager.settingsIconsColor,
                      size: 20,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRouteName.contactUs);
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                          )),
                  child: ListTile(
                    leading: const Icon(
                      Icons.dark_mode,
                      color: ColorsManager.settingsIconsColor,
                    ),
                    title: Text(
                        AppLocalizations.of(context)?.translate('dark_mode') ??
                            "dark_mode"),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.brightness_4,
                      ),
                      tooltip: 'Theme selector',
                      onPressed: () {
                        setState(() {
                          !isChanged
                              ? _lightTheme(context)
                              : _darckTheme(context);
                          isChanged = !isChanged;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
