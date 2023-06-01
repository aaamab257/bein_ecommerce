import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:dartz/dartz.dart';

import '../entities/countries_entity.dart';

class SaveCountrySelectionUseCase implements UseCase<bool ,CountryEntity>{

  CountriesRepo countriesRepo;

  SaveCountrySelectionUseCase({required this.countriesRepo});

  @override
  Future<Either<Failure, bool>> call(CountryEntity countryEntity) {
    return countriesRepo.saveCountrySelection(countryEntity);
  }
}


