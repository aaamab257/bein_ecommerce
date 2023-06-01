import 'package:bein_ecommerce/features/orders/data/models/myOrders_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class MyOrdersRepo {
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(String token);
}
