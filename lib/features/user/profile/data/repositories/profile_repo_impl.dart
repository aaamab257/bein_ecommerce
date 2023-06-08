import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/data_sources/user_profile_remote_data_source.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:bein_ecommerce/features/user/profile/domain/repositories/profile_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/network_checker/network_checker.dart';
import '../local/models/profile_data_request.dart';

class ProfileRepoImpl implements ProfileRepo{
  NetworkInfo networkInfo;
  ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.networkInfo,
    required this.profileRemoteDataSource,});

  @override
  Future<Either<Failure, UserModel>> getUserData() async{
    UserModel? userModels ;
    if (await networkInfo.isConnected) {
      (await profileRemoteDataSource.getUserData()).fold((failure) {
    return Left(ServerFailure());
    }, (userModel) {
        userModels = userModel;
    });
    } else {
    return Left(NetworkFailure());
    }
    return Right(userModels!);
  }

  @override
  Future<Either<Failure, bool>> updateUserData(ProfileDataRequest userModel) async {
    bool isUpdated = false  ;
    if (await networkInfo.isConnected) {
      (await profileRemoteDataSource.updateUserData(userModel)).fold((failure) {
    return Left(ServerFailure());
    }, (updated) {
        isUpdated = updated;
    });
    } else {
    return Left(NetworkFailure());
    }
    return Right(isUpdated);
  }
}