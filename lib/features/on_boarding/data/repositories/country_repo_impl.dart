import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/network_checker/network_checker.dart';
import 'package:bein_ecommerce/features/on_boarding/data/data_sources/getCountries.dart';
import 'package:bein_ecommerce/features/on_boarding/data/mapper.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/country.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/entities/countries_entity.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/repositories/countries_repo.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/countries_cache_data_source.dart';

class CountryRepoImpl implements CountriesRepo {
  NetworkInfo networkInfo;

  CountriesRemoteDataSource countriesRemoteDataSource;
  CountriesCacheDataSource countriesCacheDataSource;

  CountryRepoImpl(
      {required this.networkInfo,
      required this.countriesRemoteDataSource,
      required this.countriesCacheDataSource});

  @override
  Future<Either<Failure, List<CountryEntity>>> getAllCountry() async {
    List<CountryEntity> countries = [];
    if (await networkInfo.isConnected) {
      (await countriesRemoteDataSource.getAllCountries()).fold((failure) {
        return Left(ServerFailure());
      }, (countriesData) {
        countries = countriesData.map((country) => country.toEntity()).toList();
      });
    } else {
      return Left(NetworkFailure());
    }
    return Right(countries);
  }

  @override
  Future<Either<Failure, bool>> saveCountrySelection(
      CountryEntity countryEntity) async {
    if (await countriesCacheDataSource.saveCountrySelection(
        countryModel: countryEntity.toModel())) {
      return const Right(true);
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CountryEntity>> getCountrySelection() async {
    try {
      CountryModel countryModel =
          await countriesCacheDataSource.getCountrySelection();
          print("repos ======================= ${countryModel.name}");
      return Right(countryModel.toEntity()/* CountryEntity(name: countryModel.name!, id: countryModel.id!) */);
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
