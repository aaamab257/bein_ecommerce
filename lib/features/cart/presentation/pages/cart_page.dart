import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/cart/presentation/widgets/cart_with_products.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../config/localization/app_localization.dart';
import '../../../../core/shared_widgets/error_widgts.dart';
import '../../../../core/shared_widgets/loading_screen.dart';
import '../../../on_boarding/presentation/manager/countries_cubit.dart';
import '../../data/local/models/cart_model.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_state.dart';
import '../widgets/empty_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isEmpty = false;
  List<CartModel> cart = [];
  String cartId = "";
  String currency = "";
  double amount = 0.0;
  bool isLogged = false;

  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    di.sl<CountriesCubit>().getCurrentCountry().then((value) {
      setState(() {
        currency = value.currency;
      });
    });
  }

  Future<String> getCountryCurrency() async {
    String currency = "";
    await di.sl<CountriesCubit>().getCurrentCountry().then((value) {
      currency = value.currency;
    });
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<CartCubit>()..getCart(),
        child: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) => di.sl<CartCubit>(),
            builder: (context, state) {
              cart = CartCubit.get(context).cartModel;
              currency = CartCubit.get(context).getCurrency;
              print('currency =============================> $currency');
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
                      backgroundColor: ColorsManager.background,
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: cart.isEmpty
                              ? const EmptyCart()
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(5.0),
                                          itemCount: cart.length,
                                          itemBuilder: (_, index) {
                                            return Card(
                                              elevation: 0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 6.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsManager
                                                        .background,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Dismissible(
                                                  key: UniqueKey(),
                                                  onDismissed: (value) {
                                                    setState(() {
                                                      di
                                                          .sl<CartCubit>()
                                                          .decreaseProduct(
                                                              cart[index],
                                                              cart[index]
                                                                  .quantity!)
                                                          .then((value) {
                                                        setState(() {
                                                          CartCubit.get(context)
                                                              .amount -= cart[
                                                                      index]
                                                                  .product!
                                                                  .price! *
                                                              cart[index]
                                                                  .quantity!;
                                                          cart.remove(
                                                              cart[index]);
                                                        });
                                                      });
                                                    });
                                                  },
                                                  background: Container(
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            ColorsManager.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Icon(
                                                      Icons.delete_outline,
                                                      color:
                                                          ColorsManager.white,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8, bottom: 8),
                                                    child: InkWell(
                                                      highlightColor:
                                                          Colors.transparent,
                                                      splashColor:
                                                          Colors.transparent,
                                                      onTap: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white12,
                                                                    width: 1),
                                                              ),
                                                              child: Container(
                                                                width: 120,
                                                                height: 120,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      ColorsManager
                                                                          .grey,
                                                                  image: DecorationImage(
                                                                      image: /* widget.cart.image! != null ?  NetworkImage("${widget.cart.image!}") :*/
                                                                          NetworkImage(cart[index].product!.images![0].url!),
                                                                      fit: BoxFit.contain),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16,
                                                              width: 16),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  cart[index]
                                                                          .product!
                                                                          .en!
                                                                          .title ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  cart[index]
                                                                          .product!
                                                                          .en!
                                                                          .description ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      '${cart[index].product!.price!}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            32),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (cart[index].quantity! >=
                                                                            1) {
                                                                          cart[index].quantity =
                                                                              cart[index].quantity! - 1;
                                                                          CartCubit.get(context).amount -= cart[index]
                                                                              .product!
                                                                              .price!;
                                                                        }
                                                                        di
                                                                            .sl<
                                                                                CartCubit>()
                                                                            .decreaseProduct(cart[index],
                                                                                1)
                                                                            .then((value) {
                                                                          setState(
                                                                              () {
                                                                            if (cart[index].quantity! ==
                                                                                0) {
                                                                              CartCubit.get(context).amount -= cart[index].product!.price!;
                                                                              cart.remove(cart[index]);
                                                                            }
                                                                          });
                                                                        });
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(0.5),
                                                                      ),
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove_circle_outline,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child: Text(
                                                                      '${cart[index].quantity!}'),
                                                                ),
                                                                const SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        cart[index]
                                                                            .quantity = cart[index]
                                                                                .quantity! +
                                                                            1;
                                                                      });
                                                                      di
                                                                          .sl<
                                                                              CartCubit>()
                                                                          .increaseProduct(
                                                                              cart[index],
                                                                              1)
                                                                          .then((value) {
                                                                        setState(
                                                                            () {
                                                                          CartCubit.get(context).amount += cart[index]
                                                                              .product!
                                                                              .price!;
                                                                        });
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: 30,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .green
                                                                            .withOpacity(0.5),
                                                                      ),
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .add_circle_outline,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      bottomNavigationBar: cart.isEmpty
                          ? const SizedBox()
                          : Container(
                              height: 65,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .translate("total") ??
                                              "Total",
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${CartCubit.get(context).amount}",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: ColorsManager.red,
                                            textStyle: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal)),
                                        onPressed: () async {
                                          await di
                                              .sl<LoginCubit>()
                                              .getToken()
                                              .then((value) {
                                            if (value.isEmpty) {
                                              setState(() {
                                                Navigator.pushNamed(context,
                                                    AppRouteName.account);
                                              });
                                            } else {
                                              setState(() {
                                                Navigator.pushNamed(context,
                                                    AppRouteName.checkout);
                                              });
                                            }
                                          });
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                    .translate("checkout") ??
                                                "Checkout"),
                                      ),
                                    ),
                                  ],
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
                  body: Container(
                    child: _body1(),
                    color: ColorsManager.background,
                  ),
                ),
              );
            }));
  }
}
/*Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: /* widget.cart.image! != null ?  NetworkImage("${widget.cart.image!}") :*/
                                                                NetworkImage(cart[
                                                                        index]!
                                                                    .product!
                                                                    .images![0]
                                                                    .url!),
                                                            fit:
                                                                BoxFit.contain),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              cart[index]
                                                                      .product!
                                                                      .en!
                                                                      .title ??
                                                                  "",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color:
                                                                      ColorsManager
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                "${cart[index].product!.en!.description}",
                                                                            style: const TextStyle(
                                                                                color: ColorsManager.grey,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 14),
                                                                            children: [
                                                                              TextSpan(
                                                                                text: "",
                                                                                style: TextStyle(color: ColorsManager.black, fontWeight: FontWeight.w400, fontSize: 14),
                                                                              )
                                                                            ]),
                                                                      ]),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 100,
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          7),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: ColorsManager
                                                                        .grey
                                                                        .withOpacity(
                                                                            .1),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Flexible(
                                                                        flex: 1,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              cart[index].quantity = cart[index].quantity! + 1;
                                                                            });
                                                                            di.sl<CartCubit>().increaseProduct(cart[index], 1).then((value) {
                                                                              setState(() {
                                                                                CartCubit.get(context).amount += cart[index].product!.price!;
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.add,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Flexible(
                                                                        flex: 1,
                                                                        child: Text(
                                                                            '${cart[index].quantity!}'),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Flexible(
                                                                        flex: 1,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              if (cart[index].quantity! >= 1) {
                                                                                cart[index].quantity = cart[index].quantity! - 1;
                                                                                CartCubit.get(context).amount -= cart[index].product!.price!;
                                                                              }
                                                                              di.sl<CartCubit>().decreaseProduct(cart[index], 1).then((value) {
                                                                                setState(() {
                                                                                  if (cart[index].quantity! == 0) {
                                                                                    cart.remove(cart[index]);
                                                                                    CartCubit.get(context).amount -= cart[index].product!.price!;
                                                                                  }
                                                                                });
                                                                              });
                                                                            });
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.remove,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                    "${cart[index].product!.price} $currency")
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )*/
