import 'dart:ui';

import 'package:bein_ecommerce/core/utils/assets_manager/img_manger.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_state.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/onboarding.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/localization/app_localization.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/shared_widgets/error_widgts.dart';
import '../../../../core/shared_widgets/loading_screen.dart';
import '../../../../core/utils/colors/colors_manager.dart';
import '../manager/countries_cubit.dart';

class OnBoardingModels {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnBoardingModels(
      {required this.title,
      required this.description,
      required this.image,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}

class OnBoardingScreen extends StatefulWidget {
  final List<OnBoardingModels> pages;

  const OnBoardingScreen({Key? key, required this.pages}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  String cartId = "";
  var cubit = di.sl<CartCubit>();
  List<OnBoarding>? onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CartCubit>()..newCart(),
      child:BlocProvider(
                create: (context) => di.sl<CountriesCubit>()..getOnBoarding(),
                child: BlocConsumer<CountriesCubit, CountriesState>(
                  listener: (context, state) => di.sl<CountriesCubit>(),
                  builder: (context, state) {
                    onBoardingModel =
                        CountriesCubit.get(context).onBoardingModel;
                    Widget _body1() {
                      if (state is CountriesLoading) {
                        return const LoadingScreen();
                      } else if (state is CountriesError) {
                        return AppErrorWidget(
                          onPress: () {
                            setState(() {});
                          },
                        );
                      } else {
                        return Scaffold(
                          body: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            color: ColorsManager.white,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount:
                                          onBoardingModel!.length,
                                      onPageChanged: (idx) {
                                        setState(() {
                                          _currentPage = idx;
                                        });
                                      },
                                      itemBuilder: (context, idx) {
                                        final item =
                                            onBoardingModel![idx].image!;
                                        return Column(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(32.0),
                                                child: Image.network(
                                                  '${EndPoints.BASE_URL2}$item',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(32.0),
                                                child: Text(onBoardingModel![idx].title! , style: Theme.of(context).textTheme.headlineMedium,)
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(32.0),
                                                child: Text(onBoardingModel![idx].desc! , style: Theme.of(context).textTheme.headlineSmall,)
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  // Current page indicator
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: onBoardingModel!
                                        .map((item) => AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              width: _currentPage ==
                                                      onBoardingModel!.indexOf(item)
                                                  ? 20
                                                  : 4,
                                              height: 4,
                                              margin: const EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ))
                                        .toList(),
                                        
                                  ),

                                  // Bottom buttons
                                  SizedBox(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRouteName.home,
                                                  (route) => false);
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                      .translate("skip") ??
                                                  "Skip",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            if (_currentPage ==
                                                widget.pages.length - 1) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRouteName.home,
                                                  (route) => false);
                                            } else {
                                              _pageController.animateToPage(
                                                  _currentPage + 1,
                                                  curve: Curves.easeInOutCubic,
                                                  duration: const Duration(
                                                      milliseconds: 250));
                                            }
                                          },
                                          child: Text(
                                            _currentPage ==
                                                    widget.pages.length - 1
                                                ? AppLocalizations.of(context)!
                                                        .translate("finish") ??
                                                    "Finish"
                                                : AppLocalizations.of(context)!
                                                        .translate("next") ??
                                                    "Next",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    return Scaffold(
                      backgroundColor: ColorsManager.background,
                      body: _body1(),
                    );
                  },
                ),
              ),
    );
  }
}

/**/
