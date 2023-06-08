import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';

class RateView extends StatefulWidget {
  final double? starsCount;
  final int? reviewsCount;

  const RateView(
      {Key? key, required this.starsCount, required this.reviewsCount})
      : super(key: key);

  @override
  State<RateView> createState() => _RateViewState();
}

class _RateViewState extends State<RateView> {
  @override
  Widget build(BuildContext context) {
    if (widget.reviewsCount == 0 || widget.starsCount == 0) {
      return const SizedBox();
    }
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Container(
            height: 18,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
            decoration: BoxDecoration(

                color: const Color(0xff175b88),
                borderRadius: BorderRadius.circular(5),

            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.starsCount.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 3),
                  const Icon(
                    Icons.star,
                    color: ColorsManager.white,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "(${widget.reviewsCount})",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
