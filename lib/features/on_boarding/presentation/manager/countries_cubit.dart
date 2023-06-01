import 'package:bein_ecommerce/core/shared_pref/app_prefs.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/entities/countries_entity.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/use_cases/get_current_country_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/use_cases/get_all_countries.dart';
import '../../domain/use_cases/save_country_selection_usecase.dart';
part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final GetAllCountriesUseCase getAllCountriesUseCase;
  final SaveCountrySelectionUseCase saveCountrySelectionUseCase;
  final GetCurrentCountryUseCase getCurrentCountryUseCase;

  CountriesCubit({
    required this.getAllCountriesUseCase,
    required this.saveCountrySelectionUseCase,
    required this.getCurrentCountryUseCase,
  }): super(CountriesInitial());

  static CountriesCubit get(context) => BlocProvider.of(context);

  String currency = "" ;

  String get getCurrency => currency ;

  List<CountryEntity> countries = [];

  Future<List<CountryEntity>> getCountries() async {
    emit(CountriesLoading());
    (await getAllCountriesUseCase.call(NoParams())).fold((failure) {
      debugPrint("uuuuuuuuuuu" +failure.toString());
      emit(CountriesError());
    }, (countries) {
      debugPrint(countries.toString());
      this.countries = countries;
      emit(CountriesSuccess());
    });
    return countries;
  }

  Future<bool> saveCountrySelectionToLocalDB(CountryEntity countryEntity) async {
    emit(SaveCountrySelectionLoading());
    bool isSave = false;
    (await saveCountrySelectionUseCase.call(countryEntity)).fold((failure) {
      emit(SaveCountrySelectionError());
      isSave = false;
    }, (success) async {
      emit(SaveCountrySelectionSuccess());
      isSave = true;
      await getCurrentCountry();
    });
    return isSave;
  }

  
  Future<CountryEntity> getCurrentCountry() async {
    CountryEntity? countryEntity ;
    emit(GetCountrySelectionLoading());
    (await  getCurrentCountryUseCase.call(NoParams()))
       .fold((failure) {
         emit(GetCountrySelectionError());
         },
           (country){
         emit(GetCountrySelectionSuccess());
         countryEntity = country ;
         print('Cubit  ============================= ${countryEntity!.currency}');
         currency = countryEntity!.currency ;
         return country ;
       }); 
  return countryEntity! ;
  }



}
