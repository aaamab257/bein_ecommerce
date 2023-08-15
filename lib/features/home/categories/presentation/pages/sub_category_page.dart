import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/features/home/categories/data/models/sub_category_model.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/pages/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../manager/category_cubit.dart';
import '../manager/category_state.dart';

class SubCategoryScreen extends StatefulWidget {
  int id;
  SubCategoryScreen({required this.id});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  List<SubCategoryModel> subCategoryList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CategoryCubit>()..getSubCategory(widget.id),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) => di.sl<CategoryCubit>(),
        builder: (context, state) {
          subCategoryList = CategoryCubit.get(context).subCategory;

          Widget body() {
            if (state is CategoryLoading) {
              return const LoadingScreen();
            } else if (state is CategoryError) {
              return AppErrorWidget(
                onPress: () {},
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.5,
                  title: Text(
                    AppLocalizations.of(context)!.translate('services') ??
                        "Services",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                body: GridView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  itemCount: subCategoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 130,
                  ),
                  itemBuilder: (context, index) {
                    return SubCategoryItem(
                      name: subCategoryList[index].name!,
                      id: subCategoryList[index].id!,
                      products: subCategoryList[index].products!,
                    );
                  },
                ),
              );
            }
          }

          return Scaffold(
            body: body(),
          );
        },
      ),
    );
  }
}
