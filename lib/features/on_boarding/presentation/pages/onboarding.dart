import 'dart:ui';

import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../core/shared_widgets/error_widgts.dart';
import '../../../../core/shared_widgets/loading_screen.dart';
import '../../../../core/utils/colors/colors_manager.dart';

class OnBoardingModel {
  final String title;
  final String description;
  final String image;
  final Color bgColor;
  final Color textColor;

  OnBoardingModel(
      {required this.title,
      required this.description,
      required this.image,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}

class OnBoardingScreen extends StatefulWidget {
  final List<OnBoardingModel> pages;

  const OnBoardingScreen({Key? key, required this.pages}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  String cartId = "";
  var cubit = di.sl<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CartCubit>()..newCart(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) => di.sl<CartCubit>(),
        builder: (context, state) {
          cartId = CartCubit.get(context).cart_id;
          di.sl<CartCubit>().saveCartIdToLocalDB(cartId).then((value) {
            print('isSaved = ${value}');
          });
          di.sl<CartCubit>().getCartId().then((value) {
            print('Cart ID from onBo = ${value}');
          });
          Widget _body1() {
            if (state is CartLoading) {
              return const LoadingScreen();
            } else if (state is CartError) {
              return AppErrorWidget(
                onPress: () {
                  setState(() {});
                },
              );
            } else {
              return Scaffold(
                body: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  color: widget.pages[_currentPage].bgColor,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: widget.pages.length,
                            onPageChanged: (idx) {
                              setState(() {
                                _currentPage = idx;
                              });
                            },
                            itemBuilder: (context, idx) {
                              final item = widget.pages[idx];
                              return Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: Image.asset(
                                        item.image,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                              textAlign: TextAlign.center,
                                              item.title,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    color: item.textColor,
                                                  )),
                                        ),
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 280),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 8.0),
                                          child: Text(
                                              maxLines: 3,
                                              item.description,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: item.textColor,
                                                  )),
                                        )
                                      ]))
                                ],
                              );
                            },
                          ),
                        ),

                        // Current page indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.pages
                              .map((item) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: _currentPage ==
                                            widget.pages.indexOf(item)
                                        ? 20
                                        : 4,
                                    height: 4,
                                    margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ))
                              .toList(),
                        ),

                        // Bottom buttons
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {

                                    Navigator.pushNamedAndRemoveUntil(context,
                                        AppRouteName.country, (route) => false);
                                  },
                                  child: const Text(
                                    "Skip",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              TextButton(
                                onPressed: () {
                                  if (_currentPage == widget.pages.length - 1) {

                                    Navigator.pushNamedAndRemoveUntil(context,
                                        AppRouteName.country, (route) => false);
                                  } else {
                                    _pageController.animateToPage(
                                        _currentPage + 1,
                                        curve: Curves.easeInOutCubic,
                                        duration:
                                            const Duration(milliseconds: 250));
                                  }
                                },
                                child: Text(
                                  _currentPage == widget.pages.length - 1
                                      ? "Finish"
                                      : "Next",
                                  style: const TextStyle(color: Colors.white),
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
    );
  }
}
