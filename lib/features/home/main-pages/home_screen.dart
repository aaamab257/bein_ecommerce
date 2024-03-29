import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/api/dio_consumer.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/manager/category_cubit.dart';
import 'package:bein_ecommerce/features/home/products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/presentation/manager/product_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/localization/app_localization.dart';
import '../../../core/shared_widgets/bottom_nav_bar.dart';
import '../../../core/shared_widgets/error_widgts.dart';
import '../../../core/shared_widgets/loading_screen.dart';
import '../../../core/shared_widgets/menu.dart';
import '../../on_boarding/presentation/manager/countries_cubit.dart';
import '../categories/presentation/manager/category_state.dart';
import '../notification/pages/notification_page.dart';
import '../products/presentation/manager/product_state.dart';
import 'home_content_view.dart';
import 'package:bein_ecommerce/di.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var cubit = di.sl<ProductCubit>();
  List<CategoryItem> categories = [];
  String iniCountry = '';
  List<String> countries = ["EG" , "KW"];
  final int index = 0;

  @override
  void initState() {
    //  di.sl<CountriesCubit>().getCurrentCountry().then((value) {
    //   iniCountry = value.code;
    //   print(
    //       'initial Country ===========                        ========= > ${iniCountry}');
    // });
    //

    // di.sl<CountriesCubit>().getCountries().then((value) {
    //   for (var country in value) {
    //     countries.add(country.code);
    //     print('country code ======= ? ${country.code}');
    //   }
    // });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color(0xff212121),
      systemNavigationBarColor: Color(0xff212121),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height * 0.7;
    return BlocProvider(
      create: (context) => di.sl<CategoryCubit>()..getCategory(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) => di.sl<CategoryCubit>(),
        builder: (context, state) {
          categories = CategoryCubit.get(context).category;
          Widget _body1() {
            if (state is ProductsLoading) {
              return const LoadingScreen();
            } else if (state is ProductsError) {
              return AppErrorWidget(
                onPress: () {
                  setState(() {});
                },
              );
            } else {
              return HomeContent(
                w: w,
                h: h,
                context: context,
                categories: categories,
                countries: countries,
                iniCountry: iniCountry,
              );
            }
          }

          return SafeArea(
            child: Scaffold(
              appBar: buildPreferredSize(),
              body: _body1(),
            ),
          );
        },
      ),
    );
  }

  PreferredSize buildPreferredSize() {
    var size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(size.width * 0.5, 100),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.fromLTRB(10, 10, 16, 16),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.only(right: 5, left: 5),
                child: Text(
                  AppLocalizations.of(context)!.translate("welcome") ?? "Welcome in sinyar",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  
                  Navigator.pushNamed(context, AppRouteName.notifications);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.notifications_none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ), /*Container(
        margin: EdgeInsets.all(10),
        child: TextField(
          onTap: () {
            Navigator.pushNamed(context, AppRouteName.search);
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
            hintText:
                AppLocalizations.of(context)!.translate("search") ?? "Search",
          ),
        ),
      ),*/
      /* AppBar(
        elevation: 0,
        title: const Text(
          "BE IN TRACK",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          /* AnimatedBuilder(
            animation: _drawerSlideController,
            builder: (context, child) {
              return IconButton(
                onPressed: _toggleDrawer,
                icon: _isDrawerOpen() || _isDrawerOpening()
                    ? const Icon(
                  Icons.clear,
                  color: Colors.black,
                )
                    : const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              );
            },
          ), */
        ],
        backgroundColor: Colors.transparent,
      ), */
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
