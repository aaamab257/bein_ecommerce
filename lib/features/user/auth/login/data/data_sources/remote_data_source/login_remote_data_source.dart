import 'package:bein_ecommerce/core/api/end_points.dart';
import 'package:bein_ecommerce/features/cart/presentation/manager/cart_cubit.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/core/api/api_consumer.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_phone_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/register_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../../../core/error/failures.dart';
import '../../models/login_request.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, String>> login(LoginRequest request);

  Future<Either<Failure, bool>> checkPhone(CheckPhoneRequest request);

  Future<Either<Failure, bool>> checkMail(CheckMailRequest request);

  Future<Either<Failure, bool>> register(RegisterRequest request);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  ApiConsumer apiConsumer;

  LoginRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, String>> login(LoginRequest request) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.login,
          {"phoneNumber": request.phoneNumber, "otpCode": request.otpCode},
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      String token = response["token"];

      return right(token);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> checkPhone(CheckPhoneRequest request) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.check_phone,
          {"phoneNumber": request.phone},
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      bool data = response["check-phone"];
      String cartId;
      if (response['cartId'] != null) {
        cartId = response['cartId'];
        await di.sl<CartCubit>().saveCartIdToLocalDB(cartId).then((value) {
          print('isCartIdChanged ========================> $value');
        });
      }

      return right(data);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> checkMail(CheckMailRequest request) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.check_mail,
          {"email": request.email},
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      bool data = response["check-mail"];

      return right(data);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> register(RegisterRequest request) async {
    try {
      Map<String, dynamic> response = await apiConsumer.post(
          EndPoints.register,
          {
            "phoneNumber": request.phone,
            "cartId": request.cartId,
            "email": request.email,
            "countryId": request.countryId
          },
          Options(
            headers: {
              'Accept-Language': "en",
            },
          ));

      String userID = response["userId"];
      String msg = response["userId"];
      bool register = response["register"];

      return right(register);
    } on Exception catch (e) {
      print(e.toString());
    }
    return Left(ServerFailure());
  }
}
