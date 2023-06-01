import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/main-pages/home_screen.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
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

  int _selectedIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.shopping_cart_checkout_outlined,
    Icons.person_outline,
    Icons.settings_outlined,
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white10,
        fixedColor: ColorsManager.black,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: ColorsManager.black,
            ),
            label: AppLocalizations.of(context)?.translate("home") ?? "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_checkout_outlined,
                color: ColorsManager.black),
            label: AppLocalizations.of(context)?.translate("cart") ?? "Cart",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline, color: ColorsManager.black),
            label:
                AppLocalizations.of(context)?.translate("account") ?? "Account",
          ),
          BottomNavigationBarItem(
            icon:
                const Icon(Icons.settings_outlined, color: ColorsManager.black),
            label: AppLocalizations.of(context)?.translate("settings") ??
                "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      /* floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, */
      /* bottomNavigationBar: AnimatedBottomNavigationBar.builder(
      height: 60.h,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        const color =  Colors.white;
        return Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(
              iconList[index],
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                index == 0
                    ? AppLocalizations.of(context)?.translate("home") ??"Home"
                    : index == 1
                    ? AppLocalizations.of(context)?.translate("cart") ?? "Cart"
                    : index == 2
                    ? AppLocalizations.of(context)?.translate("account") ??"Account"
                    :AppLocalizations.of(context)?.translate("settings") ?? "Settings",
                maxLines: 1,
                style: TextStyle(color: color , fontSize: 15.sp),
              ),
            )
          ],
        );
      },
      backgroundColor: ColorsManager.black,
      activeIndex: _selectedIndex,
      splashColor: ColorsManager.orange,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      
      onTap: (index) {
        _onItemTapped(index);
      },
    ), */
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
