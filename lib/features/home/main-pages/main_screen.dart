import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/main-pages/home_screen.dart';
import 'package:bein_ecommerce/features/settings/presentation/pages/settings_page.dart';
import 'package:bein_ecommerce/features/user/profile/presentation/pages/account_settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../../../config/localization/app_localization.dart';
import '../../cart/presentation/pages/cart_page.dart';
import '../../on_boarding/presentation/manager/countries_cubit.dart';
import '../../requestes/presentation/pages/requestes_page.dart';
import '../../user/profile/presentation/pages/profile_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/di.dart' as di;

import '../services/pages/services_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String iniCountry = '';
  List<String> countries = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color(0xff212121),
      systemNavigationBarColor: Color(0xff212121),
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
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.category_outlined,
    Icons.menu_book_outlined,
    Icons.person_2_outlined,
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ServicesScreen(),
    RequestesScreen(),
    AccountSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = <String>[
      AppLocalizations.of(context)!.translate('home') ?? "Home",
      AppLocalizations.of(context)!.translate('services') ?? "Services",
      AppLocalizations.of(context)!.translate('requests') ?? "Requests",
      AppLocalizations.of(context)!.translate('account') ?? "Account",
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  labels[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                ),
              )
            ],
          );
        },
        backgroundColor: Theme.of(context).accentColor,
        key: _bottomNavigationKey,
        height: 80,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        _onItemTapped(0);
        //AllProductsRemoteDataSourceImpl(apiConsumer: di.sl()).getAllProducts();
      },
      child: const Icon(
        Icons.chat_bubble_outline_outlined,
      ),
    );
  }
}
