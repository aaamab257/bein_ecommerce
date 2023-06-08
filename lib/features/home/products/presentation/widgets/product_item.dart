import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/app_string/app_strings.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/products/presentation/pages/single_product_view.dart';
import 'package:bein_ecommerce/features/home/products/presentation/widgets/rate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/components.dart';
import '../../../../cart/data/local/models/cart_model.dart';
import '../../data/models/product_model.dart';

class ProductItem extends StatefulWidget {
  final bool? isNewLabelVisible;
  final ProductModel products;
  final List<CartModel> cartList;

  const ProductItem(
      {Key? key,
      required this.isNewLabelVisible,
      required this.products,
      required this.cartList})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingleProductScreen(
                  productModel: widget.products,
                  cart: widget.cartList,
                )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 67,
              height: 86,
              child: Image.network(
                widget.products.images![0].url!,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 90,
            decoration: const BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0 ),
                  child: Text(
                    widget.products.data!.title!,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    style: const TextStyle(
                        color: ColorsManager.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const RateView(starsCount: 4.5, reviewsCount: 15),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PriceWidget(
                                price: widget.products.price.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
