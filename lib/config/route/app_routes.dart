import 'package:bein_ecommerce/core/utils/app_string/app_constant.dart';
import 'package:bein_ecommerce/features/checkout/order/presentation/pages/checkout_screen.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/pages/all_category_page.dart';
import 'package:bein_ecommerce/features/home/main-pages/home_screen.dart';
import 'package:bein_ecommerce/features/home/search/presentation/pages/search_page.dart';
import 'package:bein_ecommerce/features/orders/presentation/pages/orders_screen.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/about_us.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/contact_us.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/pages/login_page.dart';
import 'package:bein_ecommerce/features/user/auth/otp/presentation/pages/otp_page.dart';
import 'package:bein_ecommerce/features/user/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import '../../core/utils/assets_manager/img_manger.dart';
import '../../features/home/main-pages/main_screen.dart';
import '../../features/home/notification/notification_page.dart';
import '../../features/home/products/presentation/pages/single_product_view.dart';
import '../../features/on_boarding/presentation/pages/country_screen.dart';
import '../../features/splash/presentation/splash_screen/screens/splash_screen.dart';
import '../../features/user/profile/presentation/pages/account_info_page.dart';

class AppRouteName {
  static const String initialRoute = '/';
  static const String home = '/home';
  static const String country = '/country';
  static const String contactUs = '/contact';
  static const String register = '/register';
  static const String singleProduct = '/singleProduct';
  static const String login = '/login';
  static const String account = '/account';
  static const String otp = '/otp';
  static const String search = '/search';
  static const String categories = '/categories';
  static const String myOrders = '/myOrders';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String notifications = '/notification';
  //about_us
  static const String about_us = '/aboutUs';

}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteName.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen1();
        });

      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) {
          return const MainScreen();
        });

      case AppRouteName.country:
        return MaterialPageRoute(builder: (context) {
          return const CountryScreen();
        });

      case AppRouteName.contactUs:
        return MaterialPageRoute(builder: (context) {
          return const ContactUsScreen();
        });

      // case AppRouteName.login:
      //   return MaterialPageRoute(builder: (context) {
      //     return LoginPage(countries: [],);
      //   });

      case AppRouteName.account:
        return MaterialPageRoute(builder: (context) {
          return const ProfilePage();
        });
      case AppRouteName.search:
        return MaterialPageRoute(builder: (context) {
          return const SearchScreen();
        });
      /*case AppRouteName.otp:
        return MaterialPageRoute(builder: (context){
          return OtpPage();
        });*/
      case AppRouteName.categories:
        return MaterialPageRoute(builder: (context) {
          return const AllCategoryPage();
        });
      case AppRouteName.checkout:
        return MaterialPageRoute(builder: (context) {
          return CheckoutScreen();
        });
      case AppRouteName.myOrders:
        return MaterialPageRoute(builder: (context) {
          return const MyOrdersScreen();
        });
      case AppRouteName.profile:
        return MaterialPageRoute(builder: (context) {
          return const AccountInfoScreen();
        });
      case AppRouteName.notifications:
        return MaterialPageRoute(builder: (context) {
          return const NotificationPage();
        });
      case AppRouteName.about_us:
        return MaterialPageRoute(builder: (context) {
          return const AboutUs();
        });

      /* case AppRouteName.singleProduct:
          return MaterialPageRoute(builder: (context) => const SingleProductScreen()
          ); */

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppConstants.noRouteFound),
              ),
            )));
  }
}
