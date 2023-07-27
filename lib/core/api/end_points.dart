import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';

class EndPoints {
  // static const String BASE_URL = 'http://192.168.100.50:8082/api/v1/';
  // static const String BASE_URL =
  //     'http://52.58.177.44:8082/api/v1/'; // Online Server
  static const String BASE_URL =
      'http://3.127.147.186:8082/api/v1/';

  static const String COUNTRIES = '${BASE_URL}countries';
  static const String PRODUCTS = '${BASE_URL}app/products';
  static const String CATEGORIES = '${BASE_URL}categories';

  //userProfile
  static const String getProfile = '${BASE_URL}users';

  // Auth Apis
  static const String login = '${BASE_URL}auth/login';
  static const String register = '${BASE_URL}auth/register';
  static const String check_phone = '${BASE_URL}auth/check-phone';
  static const String check_mail = '${BASE_URL}auth/check-mail';

  //Cart Apis
  static const String NEWCART = '${BASE_URL}carts/new-cart';

  static const String INCREASE_PRODUCT = '${BASE_URL}carts/increase-product';

  static const String DECREASE_PRODUCT = '${BASE_URL}carts/decrease-product';

  static const String GETCART = '${BASE_URL}carts/cart-id';

  static const String payType = '${BASE_URL}orders/pay-types';

  static const String placeOrder = '${BASE_URL}orders';

  static const String getMyOrders = '${BASE_URL}orders/my-orders';

  static const String socketURL = 'http://3.127.147.186:8082/ws';

  // offers
  static const String getOffers = '${BASE_URL}adds';
  static const String getOnBoarding = '${BASE_URL}onboarding';
}
