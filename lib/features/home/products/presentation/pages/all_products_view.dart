import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/home/products/data/args/arguments.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/presentation/pages/single_product_view.dart';
import 'package:bein_ecommerce/features/home/products/presentation/widgets/product_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/utils/app_string/app_constant.dart';
import '../../../../../core/utils/colors/colors_manager.dart';
import '../../../../../data/data.dart';
import '../../../../cart/data/local/models/cart_model.dart';
import '../../../../on_boarding/data/data_sources/countries_cache_data_source.dart';
import '../widgets/rate_view.dart';

class AllProductsView extends StatefulWidget {
  final List<ProductModel> products;
  final List<CartModel> cartList;

  const AllProductsView(
      {Key? key, required this.products, required this.cartList})
      : super(key: key);

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imgW = "";
    var width = MediaQuery.of(context).size.width;
    /*var height = MediaQuery.of(context).size.height;*/
    /**/
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.products.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, right: 15 , left: 15),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              /* Navigator.pushNamed(
                    context,
                    AppRouteName.singleProduct,
                    arguments: ProductDetails(widget.products[index])
                  ); */
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SingleProductScreen(
                        productModel: widget.products[index],
                        cart: widget.cartList,
                      )));
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                height: 270.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: ColorsManager.background,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: SizedBox(
                              height: 180.h,
                              width: double.infinity,
                              child: Image.network(
                                widget.products[index].images![index].url! +
                                    imgW,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            left: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  products[index]["isLiked"] =
                                  !products[index]["isLiked"];
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: Icon(
                                  Icons.favorite,
                                  color: products[index]["isLiked"]
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5 , top: 10),
                              child: Text(widget.products[index].data!.title!,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                      overflow: TextOverflow.ellipsis)),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (products[index]["stars"] == 0 ||
                                    products[index]["stars"] == null)
                                    ? const SizedBox()
                                    : RateView(
                                        starsCount: products[index]['stars'],
                                        reviewsCount: products[index]
                                        ["reviews"]),


                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    "${widget.products[index].price.toString()} ${AppConstants.currencyEn}",
                                    style: const TextStyle(
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ) ,
          );
        });
  }
}


Widget mRating(var value) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
            text: value.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.green)),
        const WidgetSpan(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child:
                Icon(Icons.radio_button_checked, color: Colors.green, size: 16),
          ),
        ),
      ],
    ),
  );
}
/**/
