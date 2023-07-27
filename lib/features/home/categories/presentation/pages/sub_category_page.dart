import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/pages/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          AppLocalizations.of(context)!.translate('services') ?? "Services",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10,
          mainAxisExtent: 130,
        ),
        itemBuilder: (context,index){
          return const SubCategoryItem() ;
        },
      ),
    );
  }
}
