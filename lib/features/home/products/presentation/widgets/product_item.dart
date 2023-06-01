import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/core/utils/app_string/app_strings.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/products/presentation/pages/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/components.dart';

class ProductItem extends StatefulWidget {
  final bool? isNewLabelVisible ;
  const ProductItem({Key? key, required this.isNewLabelVisible}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        /* Navigator.push(context, MaterialPageRoute(builder: (context) =>  SingleProductScreen(
          /* orderModel:OrderEntity(
            details: "details",
            imgUrl: "assets/images/jcb_walkthrough1.png",
            title: "Silicone Case for Apple Airpods 3 2021 (Black)",
            rating: 3.5,
            price: 119,
            detailsList: {
              "color": "red",
              "size" : 25,
              "key":"value",
              "key1":"value1",
              "key2":"value2",
              "key3":"value3",
            }
          ), */
        ),)); */
      },
      child: Center(
        child: Card(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Badge(
                  isLabelVisible: widget.isNewLabelVisible ?? false,
                  backgroundColor: ColorsManager.black,
                  largeSize: 17.h,
                  label:  Text(AppLocalizations.of(context)!.translate(AppStringsKey.newProduct)!),
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.asset('assets/images/jcb_walkthrough1.png')
                                .image)),
                  ),
                ),
                const Divider(endIndent: 5),
                Text(
                  "Silicone Case for Apple Airpods 3 2021 (Black)",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Text("rating"),
                 SizedBox(height: 2.h,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      PriceWidget(price: 119.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


