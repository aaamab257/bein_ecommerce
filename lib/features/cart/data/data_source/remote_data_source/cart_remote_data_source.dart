import 'dart:convert';

import 'package:bein_ecommerce/core/api/end_points.dart';
import 'package:bein_ecommerce/features/cart/data/local/models/cart_model.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/core/api/api_consumer.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../../core/error/failures.dart';
import '../../../../splash/presentation/localization/local_bloc/local_cubit.dart';
import '../../local/models/place_order_model.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failure, String>> newCart();

  Future<Either<Failure, bool>> increaseProduct(
      String productId, String cartId, int quantity);

  Future<Either<Failure, bool>> decreaseProduct(
      String productId, String cartId, int quantity);

  Future<Either<Failure, List<CartModel>>> getCart(String cartId);

  Future<Either<Failure, List<CartModel>>> getCartWthToken(String token);

  Future<Either<Failure, List<String>>> getPayType();

  Future<Either<Failure, bool>> placeOrder(
      String token, PlaceOrderRequest request);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  ApiConsumer apiConsumer;

  CartRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, String>> newCart() async {
    try {
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.NEWCART,
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      String data = response['id'];

      //List<ProductModel> allProducts = data.map((product) => ProductModel.fromJson(product)).toList();

      return right(data);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> increaseProduct(
      String productId, String cartId, int quantity) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.INCREASE_PRODUCT,
          {"productId": productId, "cartId": cartId, "quantity": quantity},
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      bool inc = response["increase"];

      return right(inc);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> decreaseProduct(
      String productId, String cartId, int quantity) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.DECREASE_PRODUCT,
          {"productId": productId, "cartId": cartId, "quantity": quantity},
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      dynamic data = response["decrease"];

      bool dec = data;

      return right(dec);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCart(String cartId) async {
    try {
      String lang = "";
      await di.sl<LocaleCubit>().getSavedLang().then((value) {
        lang = value;
        print('lang ============= $value');
      });
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.GETCART,
          {"cartId": cartId},
          Options(
            headers: {
              'Accept-Language': lang,
            },
          ));

      List<dynamic> data = response["cartItemDTOS"];

      print("cartItem len =================== ${data.length}");

      List<CartModel> allCartItems =
          data.map((cartItem) => CartModel.fromJson(cartItem)).toList();

      return right(allCartItems);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<String?> getCartId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cacheKey = "cartId";
    return sharedPreferences.getString(cacheKey)!;
  }

  @override
  Future<bool> saveCartId({required String cartID}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cacheKey = "cartId";
    return await sharedPreferences.setString(cacheKey, cartID);
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCartWthToken(String token) async {
    try {
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.GETCART,
          Options(
            headers: {
              'Accept-Language': "en",
              "Authorization": "Bearer $token",
            },
          ));

      List<dynamic> data = response["cartItems"];

      List<CartModel> allProducts =
          data.map((product) => CartModel.fromJson(product)).toList();

      return right(allProducts);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<String>>> getPayType() async {
    try {
      String lang = "";
      await di.sl<LocaleCubit>().getSavedLang().then((value) {
        lang = value;
        print('lang ============= $value');
      });
      List<dynamic> response = await apiConsumer.get(
          EndPoints.payType,
          Options(
            headers: {
              'Accept-Language': lang,
            },
          ));
      /*String responseData = response.toString();*/

      List<String> data = response.map((e) => e.toString()).toList();
      return right(data);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> placeOrder(
      String token, PlaceOrderRequest request) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.placeOrder,
          {
            "firstname": request.firstName,
            "lastname": request.lastName,
            "payType": request.payType,
            "email": request.email,
            "phoneNumber": request.phone,
            "address": request.address,
            "nationalId": request.nationalId,
            "months":request.months
          },
          Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));

      dynamic data = response["order-placed"];

      bool isPlaced = data;
      return right(isPlaced);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }
}
