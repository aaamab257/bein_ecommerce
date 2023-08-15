import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/main-pages/top_card.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/presentation/pages/maybe_needs.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/localization/app_localization.dart';
import '../products/presentation/pages/all_products_view.dart';
import '../slider/presentation/pages/home_slider.dart';

class HomeContent extends StatelessWidget {
  final double w;
  final double h;
  final BuildContext context;
  final List<CategoryItem> categories;
  String iniCountry = '';
  List<String> countries = [];

  HomeContent(
      {super.key,
      required this.countries,
      required this.iniCountry,
      required this.w,
      required this.h,
      required this.context,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeTopCard(countries: countries, iniCountry: iniCountry),
            const SizedBox(height: 10),
            SizedBox(
                width: double.infinity,
                height: 200.h,
                child: const HomeSlider()),
            // const SizedBox(height: 20),
            // MarksView(width: w),

            const SizedBox(height: 10),
            SizedBox(
                width: w * 0.95,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    AppLocalizations.of(context)!
                            .translate("you_can_installment") ??
                        "you_can_installment",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                )),
            const SizedBox(height: 15),
            SizedBox(
              width: w,
              height: 450, // Set the width to match the parent or a specific width
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: AllProductsView(categories: categories),
              ),
            ),
            // SizedBox(
            //   width: w,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //     child: AllProductsView(categories: categories),
            //   ),
            // ),
            // SizedBox(
            //     width: w * 0.95,
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Text(
            //         AppLocalizations.of(context)!.translate("you_maybe_need") ??
            //             "you_maybe_need",
            //         style: Theme.of(context).textTheme.headlineMedium,
            //         textAlign: TextAlign.center,
            //       ),
            //     )),
            // const SizedBox(height: 15),
            // SizedBox(
            //   width: w,
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 5.0),
            //     child: MaybeNeeds(),
            //   ),
            // ),
            const SizedBox(height: 15),
            SizedBox(
              width: w,
              height: 310,
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 231, 225, 225),
                      Color(0xff8457AB)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Stack(
                  children: [
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      start: 0,
                      child: Image.asset('assets/images/bottom_widget.png'),
                    ),
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      end: 0,
                      child: Column(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
