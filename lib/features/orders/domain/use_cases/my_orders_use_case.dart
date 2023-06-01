import 'package:bein_ecommerce/features/orders/data/models/myOrders_model.dart';
import 'package:bein_ecommerce/features/orders/domain/repositories/my_orders_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../home/products/data/models/product_model.dart';

class MyOrdersUseCase {
  MyOrdersRepo myOrdersRepo;

  MyOrdersUseCase({required this.myOrdersRepo});

  @override
  Future<Either<Failure, List<MyOrderModel>>> getMyOrders(String token) {
    return myOrdersRepo.getMyOrders(token);
  }
}
