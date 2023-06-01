import 'package:bein_ecommerce/core/utils/app_string/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class LangLocalDataSource {
  Future<bool> changeLang({required String langCode});
  Future<String> getSavedLang();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferences sharedPreferences;

  LangLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<bool> changeLang({required String langCode}) async =>
      await sharedPreferences.setString(AppConstants.locale, langCode);

  @override
  Future<String> getSavedLang() async =>
      sharedPreferences.containsKey(AppConstants.locale)
          ? sharedPreferences.getString(AppConstants.locale)!
          : AppConstants.englishCode;
}