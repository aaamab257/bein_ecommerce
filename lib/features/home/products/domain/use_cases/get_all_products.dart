import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/domain/repositories/products_repo.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:dartz/dartz.dart';



class GetAllProductsUseCase implements UseCase<List<ProductModel>, NoParams>{
  ProductsRepo productRepo;
  GetAllProductsUseCase({required this.productRepo });
  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) {
    return  productRepo.getAllProduct();
  }
}