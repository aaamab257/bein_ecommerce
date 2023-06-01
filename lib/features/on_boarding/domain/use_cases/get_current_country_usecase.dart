import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/entities/countries_entity.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:dartz/dartz.dart';

class GetCurrentCountryUseCase implements UseCase<CountryEntity , NoParams>{

   final CountriesRepo countriesRepo;

   GetCurrentCountryUseCase({required this.countriesRepo});


  @override
  Future<Either<Failure, CountryEntity>> call(NoParams params) async {
    
    
    return await countriesRepo.getCountrySelection();
  }

}