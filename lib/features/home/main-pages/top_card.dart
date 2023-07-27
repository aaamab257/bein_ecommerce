import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/shared_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../user/auth/login/presentation/pages/login_page.dart';

class HomeTopCard extends StatelessWidget {
  String iniCountry = '';
  List<String> countries = [];
  HomeTopCard({super.key, required this.countries, required this.iniCountry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate('join_now') ??
                        "Join With us now",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                            .translate('join_and_install') ??
                        "Join With us now and install any service you want",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              right: 80,
              left: 80,
              child: AppButton(
                onPressed: () {
                  Navigator.push(
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
                  );
                },
                buttonTxt:
                    AppLocalizations.of(context)!.translate('start_now') ??
                        "Start Now",
              ))
        ],
      ),
    );
  }
}
