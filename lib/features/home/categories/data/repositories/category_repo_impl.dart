import 'package:bein_ecommerce/features/home/categories/data/data_sources/all_category_remote_dataSource.dart';
import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/categories/data/models/sub_category_model.dart';
import 'package:bein_ecommerce/features/home/categories/domain/repositories/category_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/network_checker/network_checker.dart';
import '../../../products/data/models/product_model.dart';

class CategoryRepoImpl implements CategoryRepo {


  NetworkInfo networkInfo;
  AllCategoryRemoteDataSource allCategoryRemoteDataSource;

  CategoryRepoImpl({
    required this.networkInfo,
    required this.allCategoryRemoteDataSource
  });
  
  @override
  Future<Either<Failure, List<CategoryItem>>> getAllCategory() async{
     List<CategoryItem> products = [];
    if (await networkInfo.isConnected) {
      (await allCategoryRemoteDataSource.getAllCategory()).fold((failure) {
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
  Future<Either<Failure, List<SubCategoryModel>>> getAllSubCategory(int id) async{
     List<SubCategoryModel> subCategory = [];
    if (await networkInfo.isConnected) {
      (await allCategoryRemoteDataSource.getAllSubCategory(id)).fold((failure) {
        return Left(ServerFailure());
      }, (subCategories) {
        subCategory = subCategories;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(subCategory);
  }

  
}