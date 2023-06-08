import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../cart/data/local/models/cart_model.dart';
import '../../data/local/models/profile_data_request.dart';

abstract class ProfileRepo{
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, bool>> updateUserData(ProfileDataRequest userModel);
}