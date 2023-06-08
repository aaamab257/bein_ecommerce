import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../config/localization/app_localization.dart';
import '../../../products/presentation/manager/product_cubit.dart';
import '../../../products/presentation/widgets/product_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool clear = true;
  List<ProductModel> productsList = [];
  List<ProductModel> searchedResultList = [];

  TextEditingController controller = TextEditingController();

  Future<List<ProductModel>> getProducts() async {
    await di.sl<ProductCubit>().getProducts().then((value) {
      productsList = value;
    });

    return productsList;
  }

  @override
  void initState() {
    super.initState();

    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.background,
        ),
        backgroundColor: ColorsManager.background,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        child: TextField(
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              onSearchTextChanged(value);
                              clear = false;
                              if (controller.text.isEmpty) {
                                setState(() {
                                  clear = false;
                                });
                              }
                            });
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!
                                    .translate("search") ??
                                "Search",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 30,
                        height: 55,
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xff4470E2),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.search,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: InkWell(
                    //     onTap: (){

                    //     },
                    //     child: Container(
                    //       width: 30,
                    //       height: 55,
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8)),
                    //       child: const Icon(
                    //         Icons.shopping_cart_outlined,
                    //         color: ColorsManager.black,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 700,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 7.0 / 9.0,
                  children: List.generate(
                    searchedResultList.length,
                    (index) {
                      return ProductItem(
                          isNewLabelVisible: true,
                          products: searchedResultList[index],
                          cartList: const []);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchedResultList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    productsList.forEach((product) {
      if (product.data!.title!.contains(text) ||
          product.data!.description!.contains(text) ||
          product.data!.title!.startsWith(text)) {
        searchedResultList.add(product);
      }
    });

    setState(() {});
  }
}
