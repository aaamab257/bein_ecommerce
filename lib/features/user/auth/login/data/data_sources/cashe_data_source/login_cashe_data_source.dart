import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../core/error/exception.dart';

abstract class LoginCasheDataSource{
  Future<bool> saveToken({required String token});
  Future<String> getToken();
}

class LoginCasheDataSourceImpl implements LoginCasheDataSource {

  SharedPreferences sharedPreferences;
  final String cacheKey = "token";

  LoginCasheDataSourceImpl({required this.sharedPreferences});


  @override
  Future<String> getToken() async {
    if(sharedPreferences.getString(cacheKey) != null){

      return await sharedPreferences.getString(cacheKey)!;
    }else {
      throw CacheException();
    }
  }

  @override
  Future<bool> saveToken({required String token}) async{
    return await  sharedPreferences.setString(cacheKey, token);
  }

}