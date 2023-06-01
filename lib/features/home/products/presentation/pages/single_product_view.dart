import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/app_string/app_strings.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/cart_model.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/home/products/data/args/arguments.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../../../../../core/shared_widgets/components.dart';
import 'package:bein_ecommerce/di.dart' as di;

class SingleProductScreen extends StatefulWidget {
  /* final OrderEntity orderModel; */
  final ProductModel productModel;
  final List<CartModel> cart;

  const SingleProductScreen(
      {Key? key, required this.productModel, required this.cart})
      : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {


  @override
  void initState() {
    super.initState();

  }

  CartModel? getCartModel() {
    CartModel? cartModel;
    for (int i = 0; i < widget.cart.length; i++) {
      if (widget.cart[i].product!.id == widget.productModel.id) {
        cartModel = widget.cart[i];
        print('cart model =======================> ${cartModel.product!.id} ');

        return cartModel;
      } else {
        return null;
      }
    }
  }

  bool isFounded() {
    for (int i = 0; i < widget.cart.length; i++) {
      if (widget.cart[i].product!.id == widget.productModel.id) {

        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(children: [
        Stack(
          children: [
            ImageSlideshow(
              width: double.infinity,
              height: 200.h,
              isLoop: true,
              children: [
                Image.network(
                  widget.productModel.images![0].url!,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),
                Image.network(
                  widget.productModel.images![1].url!,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),
                Image.network(
                  widget.productModel.images![2].url!,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),
                Image.network(
                  widget.productModel.images![3].url!,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            AppBar(
              leading: InkWell(
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(8.h),
                  decoration: const BoxDecoration(
                    color: ColorsManager.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.productModel.data!.title!,
                textAlign: TextAlign.left,
              ),
              widget.productModel.rates == 0.0
                  ? const SizedBox()
                  : const Text("Rating"),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'By - ${widget.productModel.vendorName}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 24,
                  ),
                ],
              ),
              const Divider(),
              Text(widget.productModel.data!.description!,
                  style: Theme.of(context).textTheme.displaySmall),
              SizedBox(
                height: 16.h,
              ),
              Column(
                children: List.generate(
                    widget.productModel.data!.details!.length, (index) {
                  String detailsKey =
                      widget.productModel.data!.details!.keys.toList()[index];
                  String detailsValue = widget
                      .productModel.data!.details!.values
                      .toList()[index]
                      .toString();

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "$detailsKey :",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            detailsValue,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          margin: const EdgeInsets.all(15.0),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFounded()
                    ? Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    getCartModel()!.quantity =
                                        getCartModel()!.quantity! + 1;
                                  });
                                  di
                                      .sl<CartCubit>()
                                      .increaseProduct(getCartModel()!, 1)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text('${getCartModel()!.quantity}'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (getCartModel()!.quantity! >= 1) {
                                      getCartModel()!.quantity =
                                          getCartModel()!.quantity! - 1;
                                    }
                                    di
                                        .sl<CartCubit>()
                                        .decreaseProduct(getCartModel()!, 1)
                                        .then((value) {
                                      setState(() {
                                        if (getCartModel()!.quantity! == 0) {
                                          setState(() {

                                          });
                                        }
                                      });
                                    });
                                  });
                                },
                                child: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            di.sl<CartCubit>().addProductToCart(
                                widget.productModel.id!,
                                widget.productModel.price!,
                                1);
                            setState(() {
                              isFounded();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_shopping_cart),
                              Text(
                                AppLocalizations.of(context)
                                        ?.translate(AppStringsKey.addToCart) ??
                                    "Add To Cart",
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  width: 20.w,
                ),
                Flexible(
                  flex: 1,
                  child: PriceWidget(
                    price: widget.productModel.price.toString(),
                    customColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class OrderEntity {
  final String title;
  final String details;
  final String imgUrl;
  final double price;
  final double rating;
  final Map<String, dynamic> detailsList;

  OrderEntity(
      {required this.detailsList,
      required this.price,
      required this.title,
      required this.rating,
      required this.details,
      required this.imgUrl});
}
