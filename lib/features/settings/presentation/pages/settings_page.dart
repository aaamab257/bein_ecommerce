import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../splash/presentation/localization/local_bloc/local_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        body: Container(
          margin:const EdgeInsets.only(top: 20.0),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                    AppLocalizations.of(context)?.translate('language') ??
                        "language"),
                onTap: () {
                  AppLocalizations.of(context)!.isEnLocale
                      ? LocaleCubit.get(context).toArabic()
                      : LocaleCubit.get(context).toEnglish();
                },
              ),
              const Divider(
                height: 1,
                color: ColorsManager.grey,
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(
                    AppLocalizations.of(context)?.translate('notification') ??
                        "notification"),
                trailing: const Icon(Icons.arrow_right),
                onTap: () {},
              ),
              const Divider(
                height: 1,
                color: ColorsManager.grey,
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                    AppLocalizations.of(context)?.translate('about_us') ??
                        "about_us"),
                trailing: const Icon(Icons.arrow_right),
                onTap: () {},
              ),
              const Divider(
                height: 1,
                color: ColorsManager.grey,
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                    AppLocalizations.of(context)?.translate('contact_us') ??
                        "contact_us"),
                trailing: const Icon(Icons.arrow_right),
                onTap: () {},
              ),
              const Divider(
                height: 1,
                color: ColorsManager.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
