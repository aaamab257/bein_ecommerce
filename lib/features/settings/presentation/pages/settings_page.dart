import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../splash/presentation/localization/local_bloc/local_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, backgroundColor: ColorsManager.background,),
        backgroundColor: ColorsManager.background,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.translate("settings") ??
                    "Settings",
                style:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.language_outlined, color: Color(0xff000000),),
                  title: Text(
                      AppLocalizations.of(context)?.translate('language') ??
                          "language"),
                  onTap: () async{
                    /*setState(() {

                    });*/

                    AppLocalizations.of(context)!.isEnLocale
                        ? await LocaleCubit.get(context).toArabic()
                        : await LocaleCubit.get(context).toEnglish();
                    
                  },
                  trailing: const Icon(Icons.refresh, color: Color(0xff000000),size: 20,),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.notifications_none , color: Color(0xff000000),),
                  title: Text(
                      AppLocalizations.of(context)?.translate('notification') ??
                          "notification"),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xff000000),size: 20,),
                  onTap: () {},
                ),
              ),

              Card(
                child: ListTile(
                  focusColor: ColorsManager.lightBlue,
                  leading: const Icon(Icons.info_outline, color: Color(0xff000000),),
                  title: Text(
                      AppLocalizations.of(context)?.translate('about_us') ??
                          "about_us"),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xff000000),size: 20,),
                  onTap: () {},
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone_outlined , color: Color(0xff000000),),
                  title: Text(
                      AppLocalizations.of(context)?.translate('contact_us') ??
                          "contact_us"),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xff000000),size: 20,),
                  onTap: () {},
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}




