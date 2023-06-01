import 'package:bein_ecommerce/core/shared_widgets/outline_button.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../config/localization/app_localization.dart';
import '../../../../../config/route/app_routes.dart';

class LoggedProfile extends StatefulWidget {
  const LoggedProfile({super.key});

  @override
  State<LoggedProfile> createState() => _LoggedProfileState();
}

class _LoggedProfileState extends State<LoggedProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
      child: Stack(children: [
        Positioned(
          top: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.translate("account") ?? "account",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        AppLocalizations.of(context)
                                ?.translate("account_info") ??
                            "account_info",
                      ),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteName.profile);
                      },
                    ),
                    const Divider(
                      color: ColorsManager.grey,
                      height: 1,
                    ),
                    ListTile(
                      leading: const Icon(Icons.change_circle_rounded),
                      title: Text(
                        AppLocalizations.of(context)
                                ?.translate("change_country") ??
                            "Change_country",
                      ),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRouteName.country, (route) => false);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.list_alt_rounded),
                      title: Text(
                        AppLocalizations.of(context)?.translate("my_orders") ??
                            "My_orders",
                      ),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteName.myOrders);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: OutLinedBtn(
                  Text: Text(
                    AppLocalizations.of(context)?.translate("log_out") ??
                        "log_out",
                    style: const TextStyle(
                        color: ColorsManager.black, fontSize: 18),
                  ),
                  onPressed: () {
                    LoginCubit.get(context).saveToken("").then((value) {
                      print('isLogged Out ============ $value');

                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRouteName.home, (route) => false);
                    });
                  }),
            ),
          ),
        )
      ]),
    );
  }
}
