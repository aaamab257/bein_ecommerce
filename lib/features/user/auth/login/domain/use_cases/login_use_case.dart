import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/domain/repositories/products_repo.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_phone_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/login_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/register_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  LoginRepo loginRepo;

  LoginUseCase({required this.loginRepo});

  @override
  Future<Either<Failure, String>> login(LoginRequest loginRequest) {
    return loginRepo.login(loginRequest);
  }

  @override
  Future<Either<Failure, bool>> register(RegisterRequest request) {
    return loginRepo.register(request);
  }

  @override
  Future<Either<Failure, bool>> checkPhone(
      CheckPhoneRequest checkPhoneRequest) {
    return loginRepo.checkPhone(checkPhoneRequest);
  }

  @override
  Future<Either<Failure, bool>> checkMail(CheckMailRequest checkMailRequest) {
    return loginRepo.checkMail(checkMailRequest);
  }

  @override
  Future<Either<Failure, bool>> saveToken(String token) {
    return loginRepo.saveToken(token);
  }

  @override
  Future<Either<Failure, String>> getToken() {
    return loginRepo.getToken();
  }
}
