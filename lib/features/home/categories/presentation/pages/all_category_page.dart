import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/manager/category_cubit.dart';
import 'package:bein_ecommerce/features/home/categories/presentation/manager/category_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/localization/app_localization.dart';
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../../data/data.dart';
import 'package:bein_ecommerce/di.dart' as di;

class AllCategoryPage extends StatefulWidget {
  const AllCategoryPage({super.key});

  @override
  State<AllCategoryPage> createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {
  var cubit = di.sl<CategoryCubit>();
  List<CategoryItem> category = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CategoryCubit>()..getCategory(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) => di.sl<CategoryCubit>(),
        builder: (context, state) {
          category = CategoryCubit.get(context).category;
          Widget _body1() {
            if (state is CategoryLoading) {
              return const LoadingScreen();
            } else if (state is CategoryError) {
              return AppErrorWidget(
                onPress: () {
                  setState(() {});
                },
              );
            } else {
              return AllCategoryBody(
                categoryItem: category,
              );
            }
          }

          return SafeArea(
            child: Scaffold(
              body: _body1(),
            ),
          );
        },
      ),
    );
  }
}

class AllCategoryBody extends StatefulWidget {
  final List<CategoryItem> categoryItem;

  const AllCategoryBody({super.key, required this.categoryItem});

  @override
  State<AllCategoryBody> createState() => _AllCategoryBodyState();
}

class _AllCategoryBodyState extends State<AllCategoryBody> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            AppLocalizations.of(context)!.translate('category') ?? "Category",

          ),
        ),
        body: Container(
          width: w,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...List.generate(
                  widget.categoryItem.length,
                  (index) => InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,

                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(brandes[0]["image"]),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.categoryItem[index].name!,

                              ),
                            ],
                          ),
                          const Divider(
                            height: 1,
                            color: ColorsManager.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
