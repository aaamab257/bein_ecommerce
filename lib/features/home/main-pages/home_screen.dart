import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/api/dio_consumer.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/localization/app_localization.dart';
import '../../../core/shared_widgets/bottom_nav_bar.dart';
import '../../../core/shared_widgets/error_widgts.dart';
import '../../../core/shared_widgets/loading_screen.dart';
import '../../../core/shared_widgets/menu.dart';
import '../products/presentation/manager/product_state.dart';
import 'home_content_view.dart';
import 'package:bein_ecommerce/di.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var cubit = di.sl<ProductCubit>();
  List<ProductModel> products = [];
  final int index = 0;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Color(0xff212121),
      systemNavigationBarColor: Color(0xff212121),

    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => di.sl<ProductCubit>()..getProducts(),
      child: BlocConsumer<ProductCubit, ProductsState>(
        listener: (context, state) => di.sl<ProductCubit>(),
        builder: (context, state) {
          products = ProductCubit.get(context).products;
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
                products: products,
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
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRouteName.search);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.translate("search") ??
                              "Search",
                    ),
                  ),
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
