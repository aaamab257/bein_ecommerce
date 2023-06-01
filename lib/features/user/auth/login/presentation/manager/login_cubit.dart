import 'package:bein_ecommerce/features/home/products/data/models/product_model.dart';
import 'package:bein_ecommerce/features/home/products/domain/use_cases/get_all_products.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_mail_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/check_phone_request.dart';
import 'package:bein_ecommerce/features/user/auth/login/data/models/login_request.dart';

import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/register_request.dart';
import '../../domain/use_cases/login_use_case.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({
    required this.loginUseCase,
  }) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  List<ProductModel> products = [];
  bool isFoundedPhone = false , isRegister = false;

  bool isFoundedMail = false, isTokenSaved = false;

  String token = "", message = '';

  Future<String> login(LoginRequest loginRequest) async {
    emit(LoginLoading());
    (await loginUseCase.login(loginRequest)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(LoginError());
    }, (userToken) {
      debugPrint(userToken.toString());
      token = userToken;
      emit(LoginSuccess());
    });
    return token;
  }

  Future<bool> register(RegisterRequest request) async {
    emit(LoginLoading());
    (await loginUseCase.register(request)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(LoginError());
    }, (isRegistered) {
      debugPrint(register.toString());
      isRegister = isRegistered;
      emit(LoginSuccess());
    });
    return isRegister;
  }

  Future<bool> checkPhone(CheckPhoneRequest checkPhoneRequest) async {
    emit(CheckPhoneLoading());
    (await loginUseCase.checkPhone(checkPhoneRequest)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CheckPhoneError());
    }, (founded) {
      isFoundedPhone = founded;
      emit(CheckPhoneSuccess());
    });
    return isFoundedPhone;
  }

  Future<bool> checkMail(CheckMailRequest checkMailRequest) async {
    emit(CheckPhoneLoading());
    (await loginUseCase.checkMail(checkMailRequest)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CheckPhoneError());
    }, (founded) {
      isFoundedMail = founded;
      emit(CheckPhoneSuccess());
    });
    return isFoundedMail;
  }

  Future<bool> saveToken(String token) async {
    emit(CheckPhoneLoading());
    (await loginUseCase.saveToken(token)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(CheckPhoneError());
    }, (tokenSaved) {
      isTokenSaved = tokenSaved;
      emit(CheckPhoneSuccess());
    });
    await getToken();
    return isTokenSaved;
  }

  Future<String> getToken() async {
    emit(LoginLoading());
    (await loginUseCase.getToken()).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(LoginError());
    }, (userToken) {
      token = userToken;
      emit(LoginSuccess());
    });
    return token;
  }
}
