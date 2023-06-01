import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/assets_manager/img_manger.dart';
import '../../../../../core/utils/colors/colors_manager.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: 200.h,
      isLoop: true,
      indicatorColor: ColorsManager.black,
      indicatorRadius: 7,
      children: [
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
      ],
    );
  }
}
