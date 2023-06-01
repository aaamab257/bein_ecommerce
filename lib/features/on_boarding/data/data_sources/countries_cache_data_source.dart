import 'dart:convert';
import 'package:bein_ecommerce/core/error/exception.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/country.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CountriesCacheDataSource {
  Future<bool> saveCountrySelection({required CountryModel countryModel});
  Future<CountryModel> getCountrySelection();
}


class CountriesCacheDataSourceImpl implements CountriesCacheDataSource {
  SharedPreferences sharedPreferences;
  final String cacheKey = "currentCountry";
  CountriesCacheDataSourceImpl({required this.sharedPreferences});


  @override
  Future<bool> saveCountrySelection({required CountryModel countryModel}) async {
    return await  sharedPreferences.setString(cacheKey, jsonEncode(countryModel.toJson()));

  }

  @override
  Future<CountryModel> getCountrySelection() async {
    if(sharedPreferences.getString(cacheKey) != null){
     
      return CountryModel.fromJson(jsonDecode(sharedPreferences.getString(cacheKey)!));
    }else {
    throw CacheException();
  }
  }



}