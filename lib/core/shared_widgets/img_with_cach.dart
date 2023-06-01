
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageNetworkWithCached extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final bool isCircular;
  const ImageNetworkWithCached(
      {super.key,
        required this.imgUrl,
        this.width,
        this.height,
        this.isCircular = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCircular ? height : width?? 100,
      height: height ?? 60.h ,
      decoration: BoxDecoration(
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
              image: ExtendedImage.network(
                imgUrl,
                cache: true,
                fit: BoxFit.fill,
                border: Border.all(color: ColorsManager.grey),
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return SizedBox(
                      width: width ?? 100.w,
                      child: const LinearProgressIndicator(
                        color: ColorsManager.grey,
                      ),
                    );
                  } else if (state.extendedImageLoadState == LoadState.failed) {
                    return Container(
                      color: ColorsManager.grey,
                    );
                  }
                  return null;
                },
              ).image
          )

      ),

    );
  }
}