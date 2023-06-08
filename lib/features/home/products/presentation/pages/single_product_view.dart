import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/shared_widgets/custom_snackbar.dart';
import 'package:bein_ecommerce/core/utils/app_string/app_strings.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/cart_model.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_state.dart';
import 'package:bein_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:bein_ecommerce/features/cart/presentation/widgets/cart_drawer.dart';
import 'package:bein_ecommerce/features/home/products/data/args/arguments.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../../../../../core/shared_widgets/components.dart';
import 'package:bein_ecommerce/di.dart' as di;

import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../widgets/rate_view.dart';

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

class _SingleProductScreenState extends State<SingleProductScreen>
    with SingleTickerProviderStateMixin {
  bool founded = false;
  int len = 0;
  List<CartModel> cartList = [];
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    // di.sl<CartCubit>().isFounded(widget.productModel).then((value) {
    //   founded = value;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'cart list len  ================ 2 =================> ${widget.cart.length}');
    return BlocProvider(
      create: (context) => di.sl<CartCubit>()..getCart(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) => di.sl<CartCubit>(),
        builder: (context, state) {
          cartList = CartCubit.get(context).cartModel;

          len = cartList.length;
          founded = CartCubit.get(context).isProductFounded;

          // CartCubit.get(context).isFounded(widget.productModel).then((value) {
          //   setState(() {
          //     founded = value;
          //   });
          // });
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
              return SafeArea(
                child: Scaffold(
                  key: _key, // Assign the key to Scaffold.
                  drawer: const CartSlide(),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                                  margin: EdgeInsets.all(10.h),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff175b88),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              actions: [
                                InkWell(
                                    onTap: () {
                                      /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CartPage(
                                  index: 1,
                                )));*/
                                      _key.currentState!.openDrawer();
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      margin: EdgeInsets.all(10.h),
                                      decoration: const BoxDecoration(
                                        color: Color(0xff175b88),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Stack(
                                        children: [
                                          const Positioned(
                                            top: 0.0,
                                            right: 0.0,
                                            left: 0,
                                            bottom: 0,
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: Colors.white,
                                            ),
                                          ),
                                          CartCubit.get(context).length != 0
                                              ? Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff175b88),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${CartCubit.get(context).length}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ))
                                              : SizedBox(),
                                        ],
                                      ),
                                    ))
                              ],
                              backgroundColor: Colors.transparent,
                            ),
                          ],
                        ),
                        const Divider(),
                        /**/
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productModel.data!.title!,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                              widget.productModel.rates == 0.0
                                  ? const SizedBox()
                                  : const RateView(
                                      starsCount: 4.5, reviewsCount: 15),
                              const Divider(),
                              DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        tabs: [
                                          Tab(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                      ?.translate("desc") ??
                                                  "desc",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff175b88)),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                      ?.translate("details") ??
                                                  "details",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff175b88)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 500,
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  widget.productModel.data!
                                                      .description!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall),
                                            ],
                                          ),
                                          ListView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            children: List.generate(
                                                widget.productModel.data!
                                                    .details!.length, (index) {
                                              String detailsKey = widget
                                                  .productModel
                                                  .data!
                                                  .details!
                                                  .keys
                                                  .toList()[index];
                                              String detailsValue = widget
                                                  .productModel
                                                  .data!
                                                  .details!
                                                  .values
                                                  .toList()[index]
                                                  .toString();

                                              return Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "$detailsKey :",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      Text(
                                                        detailsValue,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff175b88),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff175b88),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                onPressed: () async {
                                  await di
                                      .sl<CartCubit>()
                                      .addProductToCart(widget.productModel.id!,
                                          widget.productModel.price!, 1)
                                      .then((value) {
                                    showSnackBar(
                                      context,
                                      AppLocalizations.of(context)!
                                              .translate('added_to_cart') ??
                                          "Added To Cart Successfully",
                                    );
                                  });
                                  await di
                                      .sl<CartCubit>()
                                      .getCart()
                                      .then((value) {
                                    setState(() {
                                      len = value.length;
                                      print(
                                          'value len ====================================== > ${value.length}');
                                      CartCubit.get(context).cartLen =
                                          value.length;
                                      CartCubit.get(context).isFoundeds = true;
                                      cartList = value;
                                    });
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_shopping_cart),
                                    Text(
                                      AppLocalizations.of(context)?.translate(
                                              AppStringsKey.addToCart) ??
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
                ),
              );
            }
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorsManager.background,
              body: _body1(),
            ),
          );
        },
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
