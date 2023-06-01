import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/presentation/pages/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/localization/app_localization.dart';
import '../../../core/shared_widgets/components.dart';
import '../../../core/shared_widgets/error_widgts.dart';
import '../../../core/shared_widgets/loading_screen.dart';
import '../../../core/utils/colors/colors_manager.dart';
import '../../cart/data/local/models/cart_model.dart';
import '../../cart/presentation/manager/cart_cubit.dart';
import '../../cart/presentation/manager/cart_state.dart';
import '../categories/presentation/pages/category_view.dart';
import '../categories/presentation/widgets/category_home_icon.dart';
import '../products/presentation/pages/all_products_view.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../slider/presentation/pages/home_slider.dart';

class HomeContent extends StatelessWidget {
  final double w;
  final double h;
  final BuildContext context;
  final List<ProductModel> products;

  const HomeContent(
      {super.key,
      required this.w,
      required this.h,
      required this.context,
      required this.products});

  @override
  Widget build(BuildContext context) {
    List<CartModel> cartList = [];
    return SizedBox(
      width: w,
      height: h,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            /* const SizedBox(height: 20), */
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            const CategoryHomeIcon(),
            const SizedBox(height: 10),
            const HomeSlider(),
            const SizedBox(height: 20),
            MarksView(width: w),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            SizedBox(
                width: w * 0.95,
                child: TitleSection(
                  text: AppLocalizations.of(context)!.translate("products") ??
                      "Products",
                  isViewMore: true,
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: w ,
              height: h ,

              child: BlocProvider(
                  create: (context) => di.sl<CartCubit>()..getCart(),
                  child: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) => di.sl<CartCubit>(),
                    builder: (context, state) {
                      cartList = CartCubit.get(context).cartModel;
                      Widget body() {
                        if (state is CartLoading) {
                          return const LoadingScreen();
                        } else if (state is CartError) {
                          return AppErrorWidget(
                            onPress: () {},
                          );
                        } else {
                          return AllProductsView(
                            products: products,
                            cartList: cartList,
                          );
                        }
                      }

                      return SafeArea(
                        child: Scaffold(
                          backgroundColor: ColorsManager.background,
                          body: body(),
                        ),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
