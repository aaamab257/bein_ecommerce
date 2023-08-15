import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../on_boarding/domain/entities/countries_entity.dart';
import '../../data/models/sub_category_model.dart';

abstract class CategoryRepo{
  Future<Either<Failure, List<CategoryItem>>> getAllCategory();
  Future<Either<Failure, List<SubCategoryModel>>> getAllSubCategory(int id );
  
}