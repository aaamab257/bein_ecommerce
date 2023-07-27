import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../config/localization/app_localization.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../core/shared_widgets/outline_button.dart';
import '../../../../../core/shared_widgets/solid_button.dart';
import '../../../../../core/utils/colors/colors_manager.dart';
import '../../../../on_boarding/presentation/manager/countries_cubit.dart';
import '../../../auth/login/presentation/pages/login_page.dart';

class GestProfile extends StatefulWidget {
  const GestProfile({super.key});

  @override
  State<GestProfile> createState() => _GestProfileState();
}

class _GestProfileState extends State<GestProfile> {
  String iniCountry = '';
  List<String> countries = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    di.sl<CountriesCubit>().getCurrentCountry().then((value) {
      iniCountry = value.code;
      print(
          'initial Country ===========                        ========= > ${iniCountry}');
    });
    //

    di.sl<CountriesCubit>().getCountries().then((value) {
      for (var country in value) {
        countries.add(country.code);
        print('country code ======= ? ${country.code}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context)
                                ?.translate("profile_notLogged_title") ??
                            "profile_notLogged_title",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context)
                                ?.translate("profile_notLogged_subTitle") ??
                            "profile_notLogged_subTitle",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SolidBtn(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRouteName.home, (route) => false);
                  },
                  Text: Text(
                    AppLocalizations.of(context)?.translate('show_shops') ??
                        "show_shops",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                OutLinedBtn(
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginPage(
                              countries: countries,
                              iniCountry: iniCountry,
                            ),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        }),
                  ),
                  Text: Text(
                    AppLocalizations.of(context)
                            ?.translate('login_or_register') ??
                        "login_or_register",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
