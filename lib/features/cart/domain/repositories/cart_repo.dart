import 'package:bein_ecommerce/features/cart/data/local/models/place_order_model.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/local/models/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, String>> newCart();

  Future<Either<Failure, bool>> increaseProduct(
      String productId, String cartId, int quantity);

  Future<Either<Failure, bool>> decreaseProduct(
      String productId, String cartId, int quantity);

  Future<Either<Failure, List<CartModel>>> getCart(String cartId);

  Future<Either<Failure, List<CartModel>>> getCartWithToken(String token);

  Future<Either<Failure, bool>> saveCartId(String cartId);

  Future<Either<Failure, String>> getCartId();

  Future<Either<Failure, List<CartModel>>> getCartList();

  Future<Either<Failure, bool>> addToCartList(List<CartModel> cartProductList);

  Future<Either<Failure, List<CartModel>>> removeFromCart(
      CartModel cartProductList);

  Future<Either<Failure, List<String>>> getPayType();

  Future<Either<Failure, bool>> placeOrder(
      String token, PlaceOrderRequest request);
}
