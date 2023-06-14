import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';

class CategoryHomeIcon extends StatelessWidget {
  const CategoryHomeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouteName.categories);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('category') ??
                              "Category",
                          style: const TextStyle(
                               fontSize: 18),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.list,

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*  decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: ColorsManager.background, spreadRadius: 1),
                ],
              ), */
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('deals') ??
                            "Deals",

                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.pending_actions,

                      ),
                    ],
                  ),
                ),
              ),
              /* decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: ColorsManager.background, spreadRadius: 1),
                ],
              ), */
            ),
          ),
        ],
      ),
    );
  }
}
