import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/pages/sub_category_page.dart';
import 'package:bein_ecommerce/features/home/products/presentation/widgets/product_item.dart';
import 'package:bein_ecommerce/features/home/services/widgets/services_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../core/utils/colors/colors_manager.dart';
import '../../../../../data/data.dart';
import '../../../../cart/data/local/models/cart_model.dart';
import '../../../../cart/presentation/manager/cart_state.dart';
import '../../data/models/product_model.dart';

class AllProductsView extends StatefulWidget {
  final List<ProductModel> products;
  const AllProductsView({Key? key, required this.products}) : super(key: key);

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imgW = "";

    /**/
    List<CartModel> cartList = [];
    return BlocProvider(
        create: (context) => di.sl<CartCubit>()..getCart(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) => di.sl<CartCubit>(),
          builder: (context, state) {
            cartList = CartCubit.get(context).cartModel;
            print(
                'cart list len  =================================> ${cartList.length}');
            Widget body() {
              if (state is CartLoading) {
                return const LoadingScreen();
              } else if (state is CartError) {
                return AppErrorWidget(
                  onPress: () {},
                );
              } else {
                return SizedBox(
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.0,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 135,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SubCategoryScreen(),
                                    transitionDuration:
                                        const Duration(milliseconds: 300),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      final tween =
                                          Tween(begin: begin, end: end);
                                      final offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            child: const ServicesWidget(
                                title: 'Test', imagePath: 'assets/image0.png'),
                          );
                        }));
              }
            }

            return SafeArea(
              child: Scaffold(
                body: body(),
              ),
            );
          },
        ));
  }
}

Widget mRating(var value) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
            text: value.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.green)),
        const WidgetSpan(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child:
                Icon(Icons.radio_button_checked, color: Colors.green, size: 16),
          ),
        ),
      ],
    ),
  );
}
/**/
