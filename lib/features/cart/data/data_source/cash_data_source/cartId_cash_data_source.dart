import 'dart:convert';
import 'package:bein_ecommerce/core/error/exception.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/country.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failures.dart';
import '../../local/models/cart_model.dart';

abstract class CartCacheDataSource {
  Future<bool> saveCartId({required String cartId});
  Future<String> getCartId();

  Future<Either<Failure,List<CartModel>>> getCartList();
  Future<bool> addToCartList(List<CartModel> cartProductList);
  Future<Either<Failure,List<CartModel>>> removeFromCart(CartModel cartModel) ;
}


class CartCacheDataSourceImpl implements CartCacheDataSource {
  SharedPreferences sharedPreferences;
  final String cacheKey = "cart_id";
  final String cartListCash = "cartList";
  CartCacheDataSourceImpl({required this.sharedPreferences});




  @override
  Future<String> getCartId() async {
    if(sharedPreferences.getString(cacheKey) != null){

      return await sharedPreferences.getString(cacheKey)!;
    }else {
      throw CacheException();
    }
  }

  @override
  Future<bool> saveCartId({required String cartId}) async{
    return await  sharedPreferences.setString(cacheKey, cartId);
  }

  @override
  Future<bool> addToCartList(List<CartModel> cartProductList) async {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
    print('carts len =================== ${carts.length}');
    return await sharedPreferences.setStringList(cartListCash, carts);
  }

  @override
  Future<Either<Failure,List<CartModel>>> getCartList() async{
    List<String>? carts = [];
    if (await sharedPreferences.containsKey(cartListCash)) {
      carts = await sharedPreferences.getStringList(cartListCash);
    }
    List<CartModel>? cartList = [];
    carts!.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))));
    return Right(cartList);
  }

  @override
  Future<Either<Failure, List<CartModel>>> removeFromCart(CartModel cartModel) async{
    List<String>? carts = [];
    if (await sharedPreferences.containsKey(cartListCash)) {
    carts = await sharedPreferences.getStringList(cartListCash);
    }
    List<CartModel>? cartList = [];
    carts!.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))));
    cartList.remove(cartModel);
    cartList.forEach((cartModel) => carts!.add(jsonEncode(cartModel)));
    await sharedPreferences.setStringList(cartListCash, carts);
    return Right(cartList);
  }



}