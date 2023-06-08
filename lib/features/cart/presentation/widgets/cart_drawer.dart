import 'package:bein_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:bein_ecommerce/features/home/products/presentation/pages/single_product_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartSlide extends StatelessWidget {
  const CartSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleProductCart(),
    );
  }
}
