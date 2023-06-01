import 'package:shared_preferences/shared_preferences.dart';
const String langKEY = "lang";
const String onBoardingKEY =
    "onBoarding";
const String loginKEY = "login";
const String showCountryKEY = "showCountry";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  // on boarding
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(onBoardingKEY, true);
  }
  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(onBoardingKEY) ??
        false;
  }



  //login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(loginKEY, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(loginKEY) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(loginKEY);
  }


  //country
  Future<bool> setShowCountries() async {
    return _sharedPreferences.setBool(showCountryKEY, true);
  }

  Future<bool> isCountriesShow() async {
    return _sharedPreferences.getBool(loginKEY) ?? false;
  }



}
