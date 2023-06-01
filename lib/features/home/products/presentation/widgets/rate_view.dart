import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';

class RateView extends StatefulWidget {
  final double? starsCount;
  final int? reviewsCount;
  const RateView({Key? key, required this.starsCount, required this.reviewsCount}) : super(key: key);

  @override
  State<RateView> createState() => _RateViewState();
}

class _RateViewState extends State<RateView> {

  @override
  Widget build(BuildContext context) {
    if(widget.reviewsCount == 0  || widget.starsCount == 0 ){
      return  const SizedBox();
    }
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.star,
          color: ColorsManager.starIconColor,
        ),
        const SizedBox(width: 5),
        Text(widget.starsCount.toString()),
        const SizedBox(width: 5),
        Text(
          "(${widget.reviewsCount} ${AppLocalizations.of(context)!.translate("review") ?? 'review' })",
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );

  }
}
