import 'package:bein_ecommerce/features/cart/data/local/models/place_order_model.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../data/local/models/cart_model.dart';
import '../../domain/use_cases/cart_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartUseCase cartUseCase;

  CartCubit({
    required this.cartUseCase,
  }) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  List<CartModel> _cartModel = [];
  List<CartModel> cartCashList = [];
  double amount = 0.0;
  String cart_id = "";
  String currency = "";

  List<ProductModel> products = [];

  List<String> _payType = [];

  int? quantity;

  List<CartModel> get cartModel => _cartModel;

  List<String> get payType => _payType;

  String get getCurrency => currency;

  double get total => amount;

  Future<String> newCart() async {
    emit(CartLoading());
    (await cartUseCase.callNewCart()).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CartError());
    }, (cartId) {
      debugPrint(cartId);
      this.cart_id = cartId;

      emit(CartSuccess());
    });
    return cart_id;
  }

  Future<bool> addProductToCart(
      String productId, double price, int quantity) async {
    emit(CartProductLoading());
    bool increase = false;
    String cartID = await getCartId();
    (await cartUseCase.callIncreaseProduct(productId, cartID, quantity)).fold(
        (failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CartError());
    }, (increased) {
      increase = increased;
      amount = amount + (price * quantity);
      amount = double.parse((amount).toStringAsFixed(2));
      emit(CartIncreaseSuccess());
    });

    return increase;
  }

  Future<bool> increaseProduct(CartModel product, int quantity) async {
    emit(CartProductLoading());
    bool increase = false;
    String cartID = await getCartId();
    (await cartUseCase.callIncreaseProduct(
            product.product!.id!, cartID, quantity))
        .fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CartError());
    }, (increased) {
      increase = increased;
      amount = amount + (product.product!.price! * product.quantity!);
      amount = double.parse((amount).toStringAsFixed(2));
      emit(CartIncreaseSuccess());
    });

    return increase;
  }

  Future<bool> decreaseProduct(CartModel product, int quantity) async {
    emit(CartProductLoading());
    bool decrease = false;
    String cartID = await getCartId();
    (await cartUseCase.callDecreaseProduct(
            product.product!.id!, cartID, quantity))
        .fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CartError());
    }, (decreased) {
      debugPrint(products.toString());
      decrease = decreased;
      amount = amount - (product.product!.price! * product.quantity!);
      amount = double.parse((amount).toStringAsFixed(2));
      emit(CartDecreaseSuccess());
    });

    return decrease;
  }

  bool isFirstBuild = true;

  Future<List<CartModel>> getCart() async {
    String cartID = await getCartId();
    emit(CartLoading());
    await di.sl<CountriesCubit>().getCurrentCountry().then((value) {
      currency = value.currency;
      print('currency =============================> ${value.currency}');
    });
    (await cartUseCase.callGetCart(cartID)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CartError());
    }, (products) {
      _cartModel = products;
      _cartModel.forEach((element) {
        amount += element.product!.price! * element.quantity!;
      });

      print('cartModel Len =================== ${_cartModel.length}');

      emit(CartSuccess());
    });

    return _cartModel;
  }

  /*Future<List<CartModel>> getCartWithToken(String token) async {

    emit(CartLoading());

    (await cartUseCase.callGetCartWithToken(token)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CartError());
    }, (products) {
      _cartModel = products;
      _cartModel.forEach((element) {
        amount += element.product!.price! * element.quantity!;
      });

      print('cartModel Len =================== ${_cartModel.length}');
      emit(CartSuccess());
    });

    return _cartModel;
  }*/

  Future<bool> saveCartIdToLocalDB(String cartId) async {
    emit(CartLoading());
    bool isSave = false;
    (await cartUseCase.saveCartId(cartId)).fold((failure) {
      emit(CartError());
      isSave = false;
    }, (success) async {
      emit(CartSuccess());
      isSave = true;
      await getCartId();
    });
    return isSave;
  }

  Future<String> getCartId() async {
    emit(CartLoading());
    (await cartUseCase.getCartId()).fold((failure) {
      emit(CartError());
    }, (cart_id) {
      emit(CartSuccess());
      this.cart_id = cart_id;
      print('Cubit Cart ID ============================= ${cart_id}');
      return cart_id;
    });
    return cart_id;
  }

  Future<List<CartModel>> getCartData() async {
    emit(CartLoading());
    (await cartUseCase.getCartList()).fold((failure) {
      emit(CartError());
    }, (cartList) {
      emit(CartSuccess());
      this.cartCashList = cartList;
      cartCashList.forEach((cart) {
        //amount = amount + (cart.cashDiscount! * cart.quantity!);
        amount = double.parse((amount).toStringAsFixed(2));
      });
      return cartCashList;
    });
    return cartCashList;
  }

  Future<bool> addToCart(CartModel cartModel) async {
    cartCashList.add(cartModel);

    //amount = amount + (cartModel.price! * cartModel.quantity!);
    amount = double.parse((amount).toStringAsFixed(2));

    emit(CartLoading());
    bool isSave = false;
    (await cartUseCase.addToCartList(cartCashList)).fold((failure) {
      emit(CartError());
      isSave = false;
    }, (success) async {
      emit(CartSuccess());
      isSave = true;
      await getCartData();
    });

    return isSave;
  }

  Future<List<CartModel>> removeFromCart(CartModel cartModel) async {
    emit(CartLoading());
    (await cartUseCase.removeFromCart(cartModel)).fold((failure) {
      emit(CartError());
    }, (cartList) {
      emit(CartSuccess());
      this.cartCashList = cartList;
      cartCashList.forEach((cart) {
        //amount = amount + (cart.cashDiscount! * cart.quantity!);
        amount = double.parse((amount).toStringAsFixed(2));
      });
      return cartCashList;
    });
    return cartCashList;
  }

  Future<List<String>> getPayType() async {
    emit(CartLoading());
    (await cartUseCase.getPayType()).fold((failure) {
      emit(CartError());
    }, (payTypeList) {
      _payType = payTypeList;
      emit(CartSuccess());
      return _payType;
    });
    return _payType;
  }

  Future<void> setQuantity(bool increment, int index) async {
    cartCashList = await getCartData();
    if (increment) {
      cartCashList[index].quantity = cartCashList[index].quantity! + 1;
      //amount = amount + cartCashList[index].price!;
      amount = double.parse((amount).toStringAsFixed(2));
      quantity = cartCashList[index].quantity!;
    } else {
      if (cartCashList[index].quantity! > 1) {
        cartCashList[index].quantity = cartCashList[index].quantity! - 1;
        //amount = amount - cartCashList[index].price!;
        amount = double.parse((amount).toStringAsFixed(2));
        quantity = cartCashList[index].quantity!;
      } else if (cartCashList[index].quantity! == 1) {
        cartCashList = await removeFromCart(cartCashList[index]);
        print('Len =================== ${cartCashList.length}');
      }
    }

    cartCashList = await getCartData();
  }

  Future<bool> placeOrder(String token, PlaceOrderRequest request) async {
    emit(CartLoading());
    bool isOrderPlaced = false;
    (await cartUseCase.orderPlace(token, request)).fold((failure) {
      emit(CartError());
      isOrderPlaced = false;
    }, (success) async {
      isOrderPlaced = success;
      emit(CartSuccess());
    });

    return isOrderPlaced;
  }

  Future<CartModel?> isExistInCart(ProductModel productModel) async {
    CartModel cartModel;
    List<CartModel> cartList = await getCart();
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].product!.id == productModel.id) {
        cartModel = cartList[i];
        return cartModel;
      } else {
        return null;
      }
    }
  }
}
