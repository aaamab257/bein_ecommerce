import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:bein_ecommerce/features/user/profile/data/local/models/user_model.dart';
import 'package:bein_ecommerce/features/user/profile/domain/use_cases/profile_use_case.dart';
import 'package:bein_ecommerce/features/user/profile/presentation/manager/profile_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit({
    required this.profileUseCase,
  }) : super(ProfileInitial());

  UserModel? userModel;
  bool updated = false;

  UserModel? get userModelData => userModel;

  bool get isUpdated => updated;

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<UserModel> getProfile() async {
    emit(ProfileLoading());

    (await profileUseCase.getUserData()).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(ProfileError());
    }, (userModels) {
      emit(ProfileSuccess());
      userModel = userModels;
      return userModel;
    });
    return userModel!;
  }

  Future<bool> updateProfile(UserModel model) async {
    emit(ProfileLoading());

    (await profileUseCase.updateUserData(model)).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(ProfileError());
    }, (isUpdated) {
      updated = isUpdated;
      emit(ProfileSuccess());
      return updated;
    });
    return false;
  }
}
