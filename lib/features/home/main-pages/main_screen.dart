import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/main-pages/home_screen.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../../../config/localization/app_localization.dart';
import '../../cart/presentation/pages/cart_page.dart';
import '../../user/profile/presentation/pages/profile_page.dart';
import '../products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/di.dart' as di;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color(0xff212121),
      systemNavigationBarColor: Color(0xff212121),
      statusBarColor: ColorsManager.background,
    ));
    AllProductsRemoteDataSourceImpl(apiConsumer: di.sl()).getAllProducts();

    super.initState();
  }

  void onConnectCallback(StompFrame connectFrame) {
    // client is connected and ready
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  int _selectedIndex = 0;
  final iconList = <IconData>[
    Icons.shopping_bag_outlined,
    Icons.shopping_cart_checkout_outlined,
    Icons.person_outline,
    Icons.settings_outlined,
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartPage(index: 0,),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap:8,
          style: GnavStyle.google,
          textStyle:const TextStyle(fontSize: 20 , color: Color(0xFF175b88) ) ,
          activeColor:const Color(0xFF175b88),
          iconSize: 20,

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          duration:const Duration(milliseconds: 500),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          tabs: [
            GButton(
              icon: Icons.shopping_bag_outlined,
              iconColor: ColorsManager.black,
              text: AppLocalizations.of(context)?.translate("home") ?? "Home",
            ),
            GButton(
              icon: Icons.shopping_cart_checkout_outlined,
              iconColor: ColorsManager.black,
              text: AppLocalizations.of(context)?.translate("cart") ?? "Cart",
            ),
            GButton(
              icon: Icons.person_outline,
              iconColor: ColorsManager.black,
              text: AppLocalizations.of(context)?.translate("account") ??
                  "Account",
            ),
            GButton(
              icon: Icons.settings_outlined,
              iconColor: ColorsManager.black,
              text: AppLocalizations.of(context)?.translate("settings") ??
                  "Settings",
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped),

    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: ColorsManager.orange,
      onPressed: () async {
        AllProductsRemoteDataSourceImpl(apiConsumer: di.sl()).getAllProducts();
      },
      child: const Icon(
        Icons.home,
        size: 24,
        color: ColorsManager.black,
      ),
    );
  }
}
