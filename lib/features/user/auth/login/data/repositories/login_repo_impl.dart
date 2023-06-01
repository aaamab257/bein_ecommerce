import 'package:bein_ecommerce/data/data.dart';
import 'package:bein_ecommerce/features/home/products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/features/home/products/domain/repositories/products_repo.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/data_sources/remote_data_source/login_remote_data_source.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_phone_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/login_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/register_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/network_checker/network_checker.dart';
import '../../domain/repositories/login_repo.dart';
import '../data_sources/cashe_data_source/login_cashe_data_source.dart';

class LoginRepoImpl implements LoginRepo {
  NetworkInfo networkInfo;
  LoginRemoteDataSource loginRemoteDataSource;
  LoginCasheDataSource loginCasheDataSource;

  LoginRepoImpl(
      {required this.networkInfo,
      required this.loginRemoteDataSource,
      required this.loginCasheDataSource});

  @override
  Future<Either<Failure, String>> login(LoginRequest loginRequest) async {
    String tokenLogin = "";
    if (await networkInfo.isConnected) {
      (await loginRemoteDataSource.login(loginRequest)).fold((failure) {
        return Left(ServerFailure());
      }, (token) {
        tokenLogin = token;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(tokenLogin);
  }

  @override
  Future<Either<Failure, bool>> checkPhone(
      CheckPhoneRequest checkPhoneRequest) async {
    bool checked = false;
    if (await networkInfo.isConnected) {
      (await loginRemoteDataSource.checkPhone(checkPhoneRequest)).fold(
          (failure) {
        return Left(ServerFailure());
      }, (founded) {
        checked = founded;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(checked);
  }

  @override
  Future<Either<Failure, bool>> checkMail(
      CheckMailRequest checkMailRequest) async {
    bool checked = false;
    if (await networkInfo.isConnected) {
      (await loginRemoteDataSource.checkMail(checkMailRequest)).fold((failure) {
        return Left(ServerFailure());
      }, (founded) {
        checked = founded;
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(checked);
  }

  @override
  Future<Either<Failure, bool>> register(RegisterRequest request) async{
    bool isRegister = false;
    if (await networkInfo.isConnected) {
      (await loginRemoteDataSource.register(request)).fold((failure) {
    return Left(ServerFailure());
    }, (registered) {
        isRegister = registered;
    });
    } else {
    return Left(NetworkFailure());
    }
    return Right(isRegister);
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      String token = await loginCasheDataSource.getToken();
      print("user token ======================= $token");
      return Right(token);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveToken(String token) async {
    if (await loginCasheDataSource.saveToken(token: token)) {
      return const Right(true);
    } else {
      return Left(CacheFailure());
    }
  }
}
