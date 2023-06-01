import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../core/error/failures.dart';
import 'package:bein_ecommerce/di.dart' as di;

import '../../../../../splash/presentation/localization/local_bloc/local_cubit.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, UserModel>> getUserData();

  Future<Either<Failure, bool>> updateUserData(UserModel user);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ApiConsumer apiConsumer;

  ProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    String token = "", lang = '';
    await di.sl<LoginCubit>().getToken().then((value) {
      token = value;
    });
    await di.sl<LocaleCubit>().getSavedLang().then((value) {
      lang = value;
    });
    try {
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.getProfile,
          Options(
            headers: {
              'Accept-Language': lang,
              "Authorization": "Bearer $token",
            },
          ));

      UserModel userModel = UserModel(
          firstName: response['firstname'] ?? '',
          lastName: response['lastname'] ?? '',
          address: response['address'] ?? '',
          email: Email(
              verified: response['email']['verified'] ?? "",
              address: response['email']['address'] ?? ""),
          phone: Phone(phoneNumber: response['phone']['phoneNumber'] ?? ""));

      return right(userModel);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> updateUserData(UserModel user) async {
    String token = "", lang = '';
    await di.sl<LoginCubit>().getToken().then((value) {
      token = value;
      print('lang ============= $value');
    });
    await di.sl<LocaleCubit>().getSavedLang().then((value) {
      lang = value;
      print('lang ============= $value');
    });
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.getProfile,
          {
            "firstname": user.firstName,
            "lastname": user.lastName,
            "address": user.address,
          },
          Options(
            headers: {
              'Accept-Language': lang,
              "Authorization": "Bearer $token",
            },
          ));

      return right(true);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }
}
