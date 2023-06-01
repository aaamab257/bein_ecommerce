import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/localization/app_localization.dart';
import '../utils/app_string/app_strings.dart';
import '../utils/colors/colors_manager.dart';

class PriceWidget extends StatelessWidget {
  final String price ;
  final Color? customColor;

  const PriceWidget({
    this.customColor,
    super.key, required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      "$price ${AppLocalizations.of(context)!.translate(AppStringsKey.currency) ?? ""}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: customColor,
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String text ;
  final bool? isViewMore ;
  const TitleSection({Key? key, required this.text, this.isViewMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          isViewMore ==true ?Text(
            AppLocalizations.of(context)!.translate("viewMore") ??"View_More",
            style:  TextStyle(
              fontSize: 18.sp,
              color: Colors.blueAccent,
            ),
          ) : const SizedBox(),
        ]);
  }
}
