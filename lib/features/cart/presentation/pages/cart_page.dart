import 'package:bein_ecommerce/config/route/app_routes.dart';

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
  final int index;

  const CartPage({super.key, required this.index});

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
                      appBar: widget.index == 1
                          ? AppBar(

                            )
                          : null,

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
                                            return Dismissible(
                                              key: UniqueKey(),
                                              background: Container(
                                                width: 50,
                                                decoration: BoxDecoration(

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Icon(
                                                  Icons.delete_outline,

                                                  size: 25,
                                                ),
                                              ),
                                              onDismissed: (value) {
                                                setState(() {
                                                  di
                                                      .sl<CartCubit>()
                                                      .decreaseProduct(
                                                          cart[index],
                                                          cart[index].quantity!)
                                                      .then((value) {
                                                    setState(() {
                                                      CartCubit.get(context)
                                                          .amount -= cart[index]
                                                              .product!
                                                              .price! *
                                                          cart[index].quantity!;
                                                      cart.remove(cart[index]);
                                                    });
                                                  });
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.network(
                                                      cart[index]
                                                          .product!
                                                          .images![0]
                                                          .url!,
                                                      width: 60,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Wrap(
                                                    direction: Axis.vertical,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 14),
                                                        child: Text(
                                                          cart[index]
                                                                  .product!
                                                                  .en!
                                                                  .title ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color: Color(
                                                                  0xff175b88),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              icon: const Icon(
                                                                  Icons.add , size: 20,),
                                                              onPressed: () {
                                                                setState(() {
                                                                  cart[index]
                                                                          .quantity =
                                                                      cart[index]
                                                                              .quantity! +
                                                                          1;
                                                                });
                                                                di
                                                                    .sl<
                                                                        CartCubit>()
                                                                    .increaseProduct(
                                                                        cart[
                                                                            index],
                                                                        1)
                                                                    .then(
                                                                        (value) {
                                                                  setState(() {
                                                                    CartCubit.get(
                                                                            context)
                                                                        .amount += cart[
                                                                            index]
                                                                        .product!
                                                                        .price!;
                                                                  });
                                                                });
                                                              }),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                '${cart[index].quantity!}'),
                                                          ),
                                                          IconButton(
                                                              icon: const Icon(
                                                                  Icons.remove, size: 20,),
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (cart[index]
                                                                          .quantity! >=
                                                                      1) {
                                                                    cart[index]
                                                                            .quantity =
                                                                        cart[index].quantity! -
                                                                            1;
                                                                    CartCubit.get(
                                                                            context)
                                                                        .amount -= cart[
                                                                            index]
                                                                        .product!
                                                                        .price!;
                                                                  }
                                                                  di
                                                                      .sl<
                                                                          CartCubit>()
                                                                      .decreaseProduct(
                                                                          cart[
                                                                              index],
                                                                          1)
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      if (cart[index]
                                                                              .quantity! ==
                                                                          0) {
                                                                        CartCubit.get(context)
                                                                            .amount -= cart[
                                                                                index]
                                                                            .product!
                                                                            .price!;
                                                                        cart.remove(
                                                                            cart[index]);
                                                                      }
                                                                    });
                                                                  });
                                                                });
                                                              }),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: Text(
                                                      '${cart[index].product!.price!}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
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
                                            primary: Color(0xff175b88),
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

                  body: Container(
                    child: _body1(),

                  ),
                ),
              );
            }));
  }
}

