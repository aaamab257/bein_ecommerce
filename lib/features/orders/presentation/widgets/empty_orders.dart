

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/localization/app_localization.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../core/shared_widgets/solid_button.dart';
import '../../../../core/utils/assets_manager/img_manger.dart';
import '../../../../core/utils/colors/colors_manager.dart';

class EmptyMyOrders extends StatelessWidget {
  const EmptyMyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              AppLocalizations.of(context)!.isEnLocale ?  ImagesManager.emptyCartEn : ImagesManager.emptyCartAr ,
              width: 300.h,
              height: 500.h,
            ),
          ),
          // Text(
          //   AppLocalizations.of(context)
          //       ?.translate("empty_orders") ??
          //       "empty_orders",
          //   style: const TextStyle(
          //       fontSize: 22, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right:20.0 , left: 20),
            child: SolidBtn(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouteName.home, (route) => false);
              },
              Text: Text(
                AppLocalizations.of(context)
                    ?.translate('show_shops') ??
                    "show_shops",
                style: const TextStyle(
                    fontSize: 18, color: ColorsManager.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
