import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/login_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/register_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../../data/models/check_phone_request.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login(LoginRequest loginRequest);

  Future<Either<Failure, bool>> register(RegisterRequest request);

  Future<Either<Failure, bool>> checkPhone(CheckPhoneRequest checkPhoneRequest);

  Future<Either<Failure, bool>> checkMail(CheckMailRequest checkMailRequest);

  // cash data to save token
  Future<Either<Failure, bool>> saveToken(String token);

  Future<Either<Failure, String>> getToken();
}
