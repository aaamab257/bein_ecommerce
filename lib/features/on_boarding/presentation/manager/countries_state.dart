part of 'countries_cubit.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();
}

class CountriesInitial extends CountriesState {
  @override
  List<Object> get props => [];
}

class CountriesLoading extends CountriesState {
  @override
  List<Object> get props => [];
}
class CountriesSuccess extends CountriesState {
  @override
  List<Object> get props => [];
}
class CountriesError extends CountriesState {
  @override
  List<Object> get props => [];
}

class SaveCountrySelectionLoading extends CountriesState {
  @override
  List<Object> get props => [];
}
class SaveCountrySelectionSuccess extends CountriesState {
  @override
  List<Object> get props => [];
}

class SaveCountrySelectionError extends CountriesState {
  @override
  List<Object> get props => [];
}

class GetCountrySelectionLoading extends CountriesState {
  @override
  List<Object> get props => [];
}
class GetCountrySelectionSuccess extends CountriesState {
  @override
  List<Object> get props => [];
}

class GetCountrySelectionError extends CountriesState {
  @override
  List<Object> get props => [];
}
