import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/features/orders/data/models/myOrders_model.dart';
import 'package:bein_ecommerce/features/orders/data/my_orders_remote_data_source.dart';
import 'package:bein_ecommerce/features/orders/domain/repositories/my_orders_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network_checker/network_checker.dart';

class MyOrdersRepoImpl implements MyOrdersRepo {
  NetworkInfo networkInfo;
  MyOrdersRemoteDataSource myOrdersRemoteDataSource;

  MyOrdersRepoImpl({
    required this.networkInfo,
    required this.myOrdersRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(String token) async {
    List<MyOrderModel> myOrdersList = [];
    if (await networkInfo.isConnected) {
      (await myOrdersRemoteDataSource.getMyOrders(token)).fold((failure) {
        return Left(ServerFailure());
      }, (myOrders) {
        myOrdersList = myOrders;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(myOrdersList);
  }
}
