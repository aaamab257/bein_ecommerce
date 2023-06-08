import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../config/localization/app_localization.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../core/utils/colors/colors_manager.dart';
import '../../../../cart/data/local/models/cart_model.dart';
import '../../../../cart/presentation/manager/cart_cubit.dart';
import '../../../../cart/presentation/manager/cart_state.dart';
import '../../../../cart/presentation/widgets/empty_cart.dart';
import '../../../../on_boarding/presentation/manager/countries_cubit.dart';
import '../../../../user/auth/login/presentation/manager/login_cubit.dart';

class SingleProductCart extends StatefulWidget {
  const SingleProductCart({Key? key}) : super(key: key);

  @override
  State<SingleProductCart> createState() => _SingleProductCartState();
}

class _SingleProductCartState extends State<SingleProductCart> {
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
                      appBar: AppBar(
                        backgroundColor: ColorsManager.background,
                      ),
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
                                            return Dismissible(
                                              key: UniqueKey(),
                                              background: Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: ColorsManager.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Icon(
                                                  Icons.delete_outline,
                                                  color: ColorsManager.white,
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
                                                      width: 50,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Wrap(
                                                    direction: Axis.vertical,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          cart[index]
                                                                  .product!
                                                                  .en!
                                                                  .title ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          '${cart[index].product!.price!}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  size: 20,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    cart[index]
                                                                            .quantity =
                                                                        cart[index].quantity! +
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
                                                                    setState(
                                                                        () {
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
                                                                      .all(5.0),
                                                              child: Text(
                                                                  '${cart[index].quantity!}'),
                                                            ),
                                                            IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  size: 20,
                                                                ),
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
                                                                        if (cart[index].quantity! ==
                                                                            0) {
                                                                          CartCubit.get(context).amount -= cart[index]
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
                                                        ),
                                                      )
                                                    ],
                                                  )),
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
