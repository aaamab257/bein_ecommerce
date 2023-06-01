import 'package:bein_ecommerce/core/utils/app_string/app_constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/local_use_case/change_local_lang.dart';
import '../../../domain/usecases/local_use_case/get_saved_lang.dart';
part 'local_state.dart';

class LocaleCubit extends Cubit<LocaleState> {

  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  LocaleCubit({required this.getSavedLangUseCase,required this.changeLangUseCase}) : super(const ChangeLocaleState(Locale(AppConstants.englishCode)));
  static LocaleCubit get(context)=>BlocProvider.of(context);

  String currentLangCode = AppConstants.englishCode;
  Future<String> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppConstants.cacheFailure), (value) {
      currentLangCode = value ;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
    return currentLangCode ;
  }

  Future<void> _changeLang(String langCode) async {

    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppConstants.cacheFailure), (value) {
      emit(ChangeLocaleStateLoading(Locale(langCode)));
      currentLangCode = langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  void toEnglish() => _changeLang(AppConstants.englishCode);

  void toArabic() => _changeLang(AppConstants.arabicCode);

}
