import 'package:bein_ecommerce/features/home/services/widgets/subsub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../config/localization/app_localization.dart';
import '../../../requestes/presentation/widgets/current_requestes.dart';
import '../../categories/data/models/sub_category_model.dart';

class SubSubCategoryPage extends StatefulWidget {
  List<Product> products;
  SubSubCategoryPage({super.key, required this.products});

  @override
  State<SubSubCategoryPage> createState() => _SubSubCategoryPageState();
}

class _SubSubCategoryPageState extends State<SubSubCategoryPage>
    with SingleTickerProviderStateMixin {
  var _tabController;
  final List<Tab> tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  );
                },
              );
            },
          )
        ],
        title: Text(
            AppLocalizations.of(context)!.translate('services') ?? "Services"),
        elevation: 0.5,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.all(15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.translate('products') ??
                        "Products",
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.translate('provider') ??
                        "Providers",
                  ),
                ],
                labelStyle: Theme.of(context).textTheme.headlineSmall,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).accentColor,
                indicatorColor: const Color(0xff88489E),
                indicator: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    itemCount: widget.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      // width / height: fixed for *all* items
                      childAspectRatio: 0.5,
                      mainAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) {
                      return SubSubCategoryItem(
                        id: widget.products[index].id!,
                        name: widget.products[index].name!,
                        price: widget.products[index].price!,
                        desc: widget.products[index].description!,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  // child: ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: 3,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return const CurrentRequeste();
                  //   },
                  // ),
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
