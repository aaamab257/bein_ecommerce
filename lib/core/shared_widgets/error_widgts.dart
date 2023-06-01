import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/localization/app_localization.dart';


class AppErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  const AppErrorWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: ColorsManager.orange,
            size: 150.h,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            AppLocalizations.of(context)!.translate('something_went_wrong') ?? "something_went_wrong",
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.translate('try_again') ?? "try_again",
          style: const TextStyle(
              color: ColorsManager.grey, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: ColorsManager.orange,
                backgroundColor: ColorsManager.black,
                elevation: 500,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              AppLocalizations.of(context)!.translate('reload_screen')?? "reload_screen",
              style: const TextStyle(
                  color: ColorsManager.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              if (onPress != null) {
                onPress!();
              }
            },
          ),
        )
      ],
    );
  }
}