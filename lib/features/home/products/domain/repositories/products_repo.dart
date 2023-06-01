import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../on_boarding/domain/entities/countries_entity.dart';

abstract class ProductsRepo{
  Future<Either<Failure, List<ProductModel>>> getAllProduct();
  
}