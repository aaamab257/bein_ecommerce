import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/error_widgts.dart';
import '../../../../core/shared_widgets/loading_screen.dart';
import '../../../../core/utils/colors/colors_manager.dart';
import '../../data/local/models/cart_model.dart';
import '../manager/cart_state.dart';
import 'cart_item.dart';

class CartBody extends StatefulWidget {
  List<CartModel> cart = [];

  double amount;

  CartBody({super.key, required this.cart, required this.amount});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              itemCount: widget.cart.length,
              itemBuilder: (_, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (value) {
                    di.sl<CartCubit>().decreaseProduct(
                          widget.cart[index],
                          widget.cart[index].quantity!,
                        );
                    print(
                        "cart Model ==========1======= ${di.sl<CartCubit>().cartModel.length}");
                  },
                  background: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: ColorsManager.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.delete_outline,
                      color: ColorsManager.white,
                      size: 25,
                    ),
                  ),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: /* widget.cart.image! != null ?  NetworkImage("${widget.cart.image!}") :*/
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
                                  widget.cart[index].product!.en!.title ?? "",
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
                                            text:
                                                "${widget.cart[index].product!.en!.description}",
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
                                        color:
                                            ColorsManager.grey.withOpacity(.1),
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.cart[index].quantity =
                                                      widget.cart[index]
                                                              .quantity! +
                                                          1;
                                                });
                                                di
                                                    .sl<CartCubit>()
                                                    .increaseProduct(
                                                        widget.cart[index],
                                                        1);
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
                                            child: Text(
                                                '${widget.cart[index].quantity!}'),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.cart[index].quantity =
                                                      widget.cart[index]
                                                              .quantity! -
                                                          1;
                                                });
                                                di
                                                    .sl<CartCubit>()
                                                    .decreaseProduct(
                                                        widget.cart[index], 1);
                                              },
                                              child: const Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                        "${widget.cart[index].product!.price} LE")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
    );
  }
}
