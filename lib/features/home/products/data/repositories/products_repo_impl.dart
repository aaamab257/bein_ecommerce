import 'package:bein_ecommerce/data/data.dart';
import 'package:bein_ecommerce/features/home/products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/features/home/products/domain/repositories/products_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/network_checker/network_checker.dart';
import '../../../../on_boarding/data/models/onboarding.dart';
import '../models/slider_model.dart';

class ProductsRepoImpl implements ProductsRepo {


  NetworkInfo networkInfo;
  AllProductsRemoteDataSource allProductsRemoteDataSource;

  ProductsRepoImpl({
    required this.networkInfo,
    required this.allProductsRemoteDataSource
  });
  
  @override
  Future<Either<Failure, List<ProductModel>>> getAllProduct() async{
     List<ProductModel> products = [];
    if (await networkInfo.isConnected) {
      (await allProductsRemoteDataSource.getAllProducts()).fold((failure) {
        return Left(ServerFailure());
      }, (productsData) {
        products = productsData;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(products);
  }

  @override
  Future<Either<Failure, OffersModel>> getOffers() async {
    OffersModel? offersModel ;
    if (await networkInfo.isConnected) {
      (await allProductsRemoteDataSource.getOffers()).fold((failure) {
        return Left(ServerFailure());
      }, (offers) {

        offersModel = offers;

      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(offersModel!);
  }
  
}
