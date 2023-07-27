import 'package:bein_ecommerce/features/home/products/presentation/manager/product_cubit.dart';
import 'package:bein_ecommerce/features/home/products/presentation/manager/product_state.dart';
import 'package:bein_ecommerce/features/home/slider/presentation/manager/offers_cubit.dart';
import 'package:bein_ecommerce/features/home/slider/presentation/manager/offers_state.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../core/utils/assets_manager/img_manger.dart';
import '../../../../../core/utils/colors/colors_manager.dart';
import '../../../products/data/models/slider_model.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  OffersModel offersModel = OffersModel();
  List<Widget> imgs = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocProvider(
        create: (context) => di.sl<OffersCubit>()..getOffers(),
        child: BlocConsumer<OffersCubit, OffersState>(
          listener: (context, state) => di.sl<OffersCubit>(),
          builder: (context, state) {
            imgs = OffersCubit.get(context).imgs;
            offersModel = OffersCubit.get(context).offersModel;
            debugPrint(
                'offer Model ============================ ${offersModel.id}');

            Widget _body1() {
              if (state is OffersLoading) {
                return const LoadingScreen();
              } else if (state is OffersError) {
                return AppErrorWidget(
                  onPress: () {},
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ImageSlideshow(
                      width: double.infinity,
                      height: 200.h,
                      autoPlayInterval: 3000,
                      isLoop: true,
                      indicatorBackgroundColor: const Color(0xff54c8f7),
                      indicatorColor: const Color(0xff175b88),
                      indicatorRadius: 3,
                      children: imgs,
                    ),
                  ),
                );
              }
            }

            return Scaffold(
              body: _body1(),
            );
          },
        ),
      ),
    );
  }
}

/**/
/*[
                  Image.asset(
                    ImagesManager.bannerDemo1,
                    height: 250.h,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    ImagesManager.bannerDemo2,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    ImagesManager.bannerDemo3,
                    height: 250.h,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    ImagesManager.bannerDemo4,
                    height: 250.h,
                    fit: BoxFit.cover,
                  ),
                ],*/
