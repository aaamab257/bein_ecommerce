import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/countries_entity.dart';

abstract class CountriesRepo{
  Future<Either<Failure, List<CountryEntity>>> getAllCountry();
  Future<Either<Failure, bool>> saveCountrySelection(CountryEntity countryEntity);
  Future<Either<Failure, CountryEntity>> getCountrySelection();
}

