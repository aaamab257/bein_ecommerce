import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../cart/data/local/models/cart_model.dart';
import '../repositories/profile_repo.dart';

class ProfileUseCase {
  ProfileRepo profileRepo;

  ProfileUseCase({required this.profileRepo});

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    return await profileRepo.getUserData();
  }

  @override
  Future<Either<Failure, bool>> updateUserData(UserModel userModel) async {
    return await profileRepo.updateUserData(userModel);
  }
}
