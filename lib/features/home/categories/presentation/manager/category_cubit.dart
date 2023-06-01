import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/categories/domain/use_cases/get_all_category.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/domain/use_cases/get_all_products.dart';
import 'package:bein_ecommerce/features/home/products/presentation/manager/product_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../on_boarding/domain/entities/countries_entity.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState>{
 final GetAllCategoryUseCase getAllCategoryUseCase;
  

  CategoryCubit({
    required this.getAllCategoryUseCase,
    
  }): super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  List<CategoryItem> category = [];

  Future<List<CategoryItem>> getCategory() async {
    emit(CategoryLoading());
    (await getAllCategoryUseCase.call(NoParams())).fold((failure) {
      debugPrint("uuuuuuuuuuu" +failure.toString());
      emit(CategoryError());
    }, (category) {
      debugPrint(category.toString());
      this.category = category;
      emit(CategorySuccess());
    });
    return category;
  }

}