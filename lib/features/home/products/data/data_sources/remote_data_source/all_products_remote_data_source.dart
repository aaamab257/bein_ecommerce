import 'package:bein_ecommerce/core/api/end_points.dart';
import 'package:bein_ecommerce/core/api/api_consumer.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bein_ecommerce/di.dart' as di;

import '../../../../../../core/error/failures.dart';
import '../../../../../splash/presentation/localization/local_bloc/local_cubit.dart';
import '../../models/product_model.dart';
import '../../models/slider_model.dart';

abstract class AllProductsRemoteDataSource {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();

  Future<Either<Failure, OffersModel>> getOffers();
}

class AllProductsRemoteDataSourceImpl implements AllProductsRemoteDataSource {
  ApiConsumer apiConsumer;

  AllProductsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      String lang = "";
      await di.sl<LocaleCubit>().getSavedLang().then((value) {
        lang = value;
        print('lang ============= $value');
      });
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.PRODUCTS,
          Options(
            headers: {
              'Accept-Language': lang,
            },
          ));

      List<dynamic> data = response["content"];

      List<ProductModel> allProducts =
          data.map((product) => ProductModel.fromJson(product)).toList();

      return right(allProducts);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, OffersModel>> getOffers() async {
    String lang = "";
    await di.sl<LocaleCubit>().getSavedLang().then((value) {
      lang = value;
      print('lang ============= $value');
    });
    try {
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.getOffers,
          Options(
            headers: {
              'Accept-Language': lang,
            },
          ));

      dynamic id = response['id'];
      List<dynamic> images = response['enImages'];
      List<Imgs> imgs = images.map((image) => Imgs.fromJson(image)).toList();

      OffersModel offersModel = OffersModel(id: id, images: imgs);
      return right(offersModel);
    } on Exception catch (e) {
      print(e.toString());
    }

    return Left(ServerFailure());
  }
}
