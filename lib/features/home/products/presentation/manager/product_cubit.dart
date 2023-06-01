import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/domain/use_cases/get_all_products.dart';
import 'package:bein_ecommerce/features/home/products/presentation/manager/product_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../on_boarding/domain/entities/countries_entity.dart';

class ProductCubit extends Cubit<ProductsState>{
 final GetAllProductsUseCase getAllProductsUseCase;
  

  ProductCubit({
    required this.getAllProductsUseCase,
    
  }): super(ProductsInitial());

  static ProductCubit get(context) => BlocProvider.of(context);

  List<ProductModel> products = [];

  Future<List<ProductModel>> getProducts() async {
    emit(ProductsLoading());
    (await getAllProductsUseCase.call(NoParams())).fold((failure) {
      debugPrint("uuuuuuuuuuu" +failure.toString());
      emit(ProductsError());
    }, (products) {
      debugPrint(products.toString());
      this.products = products;
      emit(ProductsSuccess());
    });
    return products;
  }

}