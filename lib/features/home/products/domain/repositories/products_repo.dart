import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../on_boarding/data/models/onboarding.dart';
import '../../../../on_boarding/domain/entities/countries_entity.dart';
import '../../data/models/slider_model.dart';

abstract class ProductsRepo{
  Future<Either<Failure, List<ProductModel>>> getAllProduct();
  Future<Either<Failure, List<Imgs>>> getOffers();
}