import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/onboarding.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:dartz/dartz.dart';

import '../entities/countries_entity.dart';

class GetAllCountriesUseCase implements UseCase<List<CountryEntity>, NoParams>{
  CountriesRepo countriesRepo;
  GetAllCountriesUseCase({required this.countriesRepo });
  @override
  Future<Either<Failure, List<CountryEntity>>> call(NoParams params) {
    return  countriesRepo.getAllCountry();
  }

  @override
  Future<Either<Failure, List<OnBoarding>>> getAllOnBoarding(NoParams params) {
    return  countriesRepo.getOnBoarding();
  }
}