import 'package:bein_ecommerce/features/cart/data/local/models/cart_model.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/place_order_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network_checker/network_checker.dart';
import '../../../home/products/data/models/product_model.dart';
import '../../domain/repositories/cart_repo.dart';
import '../data_source/cash_data_source/cartId_cash_data_source.dart';
import '../data_source/remote_data_source/cart_remote_data_source.dart';

class CartRepoImpl implements CartRepo {
  NetworkInfo networkInfo;
  CartRemoteDataSource cartRemoteDataSource;
  CartCacheDataSource cartCacheDataSource;

  CartRepoImpl(
      {required this.networkInfo,
      required this.cartRemoteDataSource,
      required this.cartCacheDataSource});

  @override
  Future<Either<Failure, String>> newCart() async {
    String cartId = "";
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.newCart()).fold((failure) {
        return Left(ServerFailure());
      }, (cart_id) {
        cartId = cart_id;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(cartId);
  }

  @override
  Future<Either<Failure, bool>> increaseProduct(
      String productId, String cartId, int quantity) async {
    bool inc = false;
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.increaseProduct(productId, cartId, quantity))
          .fold((failure) {
        return Left(ServerFailure());
      }, (increase) {
        inc = increase;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(inc);
  }

  @override
  Future<Either<Failure, bool>> decreaseProduct(
      String productId, String cartId, int quantity) async {
    bool dec = false;
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.decreaseProduct(productId, cartId, quantity))
          .fold((failure) {
        return Left(ServerFailure());
      }, (decrease) {
        dec = decrease;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(dec);
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCart(String cartId) async {
    List<CartModel> products = [];
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.getCart(cartId)).fold((failure) {
        return Left(ServerFailure());
      }, (productsData) {
        products = productsData;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(products);
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartWithToken(
      String token) async {
    List<CartModel> products = [];
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.getCartWthToken(token)).fold((failure) {
        return Left(ServerFailure());
      }, (productsData) {
        products = productsData;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(products);
  }

  @override
  Future<Either<Failure, bool>> saveCartId(String cartId) async {
    if (await cartCacheDataSource.saveCartId(cartId: cartId)) {
      return const Right(true);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCartId() async {
    try {
      String cartId = await cartCacheDataSource.getCartId();
      print("cart ID  ======================= ${cartId}");
      return Right(cartId);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addToCartList(
      List<CartModel> cartProductList) async {
    if (await cartCacheDataSource.addToCartList(cartProductList)) {
      return Right(true);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartList() async {
    List<CartModel> cart = [];
    if (await networkInfo.isConnected) {
      (await cartCacheDataSource.getCartList()).fold((failure) {
        return Left(ServerFailure());
      }, (cartData) {
        cart = cartData;
      });
      return Right(cart);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> removeFromCart(
      CartModel cartModel) async {
    List<CartModel> cart = [];
    if (await networkInfo.isConnected) {
      (await cartCacheDataSource.removeFromCart(cartModel)).fold((failure) {
        return Left(ServerFailure());
      }, (cartData) {
        cart = cartData;
      });
      return Right(cart);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPayType() async {
    List<String> type = [];
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.getPayType()).fold((failure) {
        return Left(ServerFailure());
      }, (payType) {
        type = payType;
      });
      return Right(type);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> placeOrder(
      String token, PlaceOrderRequest request) async {
    bool isOrderPlaced = false;
    if (await networkInfo.isConnected) {
      (await cartRemoteDataSource.placeOrder(token, request)).fold((failure) {
        return Left(ServerFailure());
      }, (orderPlaced) {
        isOrderPlaced = orderPlaced;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(isOrderPlaced);
  }
}
