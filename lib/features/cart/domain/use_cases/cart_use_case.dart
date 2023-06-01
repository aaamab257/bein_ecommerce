import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/cart_model.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/place_order_model.dart';
import 'package:bein_ecommerce/features/cart/domain/repositories/cart_repo.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/domain/repositories/products_repo.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartUseCase {
  CartRepo cartRepo;

  CartUseCase({required this.cartRepo});

  @override
  Future<Either<Failure, String>> callNewCart() {
    return cartRepo.newCart();
  }

  @override
  Future<Either<Failure, bool>> callIncreaseProduct(
      String productId, String cartId, int quantity) {
    return cartRepo.increaseProduct(productId, cartId, quantity);
  }

  @override
  Future<Either<Failure, bool>> callDecreaseProduct(
      String productId, String cartId, int quantity) {
    return cartRepo.decreaseProduct(productId, cartId, quantity);
  }

  @override
  Future<Either<Failure, List<CartModel>>> callGetCart(
    String cartId,
  ) {
    return cartRepo.getCart(cartId);
  }

  @override
  Future<Either<Failure, List<CartModel>>> callGetCartWithToken(String token) {
    return cartRepo.getCartWithToken(token);
  }

  @override
  Future<Either<Failure, bool>> saveCartId(String cartId) {
    return cartRepo.saveCartId(cartId);
  }

  @override
  Future<Either<Failure, String>> getCartId() {
    return cartRepo.getCartId();
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartList() async {
    return await cartRepo.getCartList();
  }

  @override
  Future<Either<Failure, List<String>>> getPayType() async {
    return await cartRepo.getPayType();
  }

  @override
  Future<Either<Failure, bool>> addToCartList(
      List<CartModel> cartProductList) async {
    return await cartRepo.addToCartList(cartProductList);
  }

  @override
  Future<Either<Failure, List<CartModel>>> removeFromCart(
      CartModel cartProductList) async {
    return await cartRepo.removeFromCart(cartProductList);
  }

  @override
  Future<Either<Failure, bool>> orderPlace(
      String token, PlaceOrderRequest request) {
    return cartRepo.placeOrder(token, request);
  }
}
