import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/home/products/presentation/widgets/product_item.dart';
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
            print('cart list len  =================================> ${cartList.length}');
            Widget body() {
              if (state is CartLoading) {
                return const LoadingScreen();
              } else if (state is CartError) {
                return AppErrorWidget(
                  onPress: () {},
                );
              } else {
                return SizedBox(
                    child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 7.0 / 9.0,
                  children: List.generate(
                    widget.products.length,
                    (index) {
                      return ProductItem(
                          isNewLabelVisible: true,
                          products: widget.products[index],
                          cartList: cartList);
                    },
                  ),
                ));
              }
            }

            return SafeArea(
              child: Scaffold(
                backgroundColor: ColorsManager.background,
                body: body(),
              ),
            );
          },
        ));
  }
}
/*GestureDetector(
          onTap: () {

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SingleProductScreen(
                      productModel: widget.products[index],
                      cart: widget.cartList,
                    )));
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorsManager.background,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              widget.products[index].images![index].url! + imgW,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                products[index]["isLiked"] =
                                    !products[index]["isLiked"];
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 20,
                              child: Icon(
                                Icons.favorite,
                                color: products[index]["isLiked"]
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: Text(widget.products[index].data!.title!,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(overflow: TextOverflow.ellipsis)),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  "${widget.products[index].price.toString()} ${AppConstants.currencyEn}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              (products[index]["stars"] == 0 ||
                                  products[index]["stars"] == null)
                                  ? const SizedBox()
                                  : RateView(
                                  starsCount: products[index]['stars'],
                                  reviewsCount: products[index]["reviews"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )*/

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
