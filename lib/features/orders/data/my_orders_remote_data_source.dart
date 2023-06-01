import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../core/api/api_consumer.dart';
import '../../../core/api/end_points.dart';
import '../../../core/error/failures.dart';
import '../../splash/presentation/localization/local_bloc/local_cubit.dart';
import 'models/myOrders_model.dart';

abstract class MyOrdersRemoteDataSource {
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(String token);
}

class MyOrdersRemoteDataSourceImpl implements MyOrdersRemoteDataSource {
  ApiConsumer apiConsumer;

  MyOrdersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(String token) async {
    try {
      String lang = "";
      await di.sl<LocaleCubit>().getSavedLang().then((value) {
        lang = value;
        print('lang ============= $value');
      });
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.getMyOrders,
          Options(
            headers: {
              'Accept-Language': lang,
              "Authorization": "Bearer $token",
            },
          ));

      List<dynamic> data = response["content"];

      List<MyOrderModel> allProducts = [];
      allProducts =
          data.map((product) => MyOrderModel.fromJson(product)).toList();

      return right(allProducts);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }
}
