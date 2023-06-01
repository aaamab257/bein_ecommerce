import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../data/local/models/cart_model.dart';

class CartItem extends StatefulWidget {
  final CartModel cart;

  final int index;

  const CartItem({super.key, required this.cart, required this.index});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /*child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: *//* widget.cart.image! != null ?  NetworkImage("${widget.cart.image!}") :*//*
                      AssetImage('images/products/product0.png'),
                  fit: BoxFit.contain),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cart.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorsManager.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "${widget.cart.disc!}",
                              style: const TextStyle(
                                  color: ColorsManager.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: [
                                TextSpan(
                                  text: "",
                                  style: TextStyle(
                                      color: ColorsManager.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorsManager.grey.withOpacity(.1),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  di
                                      .sl<CartCubit>()
                                      .setQuantity(true, widget.index)
                                      .then((value) {
                                    print(
                                        'Done ========================= added 1 ');
                                    setState(() {
                                      widget.cart.quantity =
                                          widget.cart.quantity! + 1;
                                    });
                                  });
                                  *//* cartViewModel.increQuantity(order,order.product!.inventory![0]); *//*
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text('${widget.cart.quantity!}'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  di
                                      .sl<CartCubit>()
                                      .setQuantity(false, widget.index)
                                      .then((value) {
                                    print(
                                        'Done ========================= remove 1 ');
                                    setState(() {
                                      widget.cart.quantity =
                                          widget.cart.quantity! - 1;
                                    });
                                  });
                                  *//* cartViewModel.deceQuanity(order); *//*
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text("${widget.cart[index].price} LE")
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),*/
    );
  }
}
