import 'package:bein_ecommerce/core/api/api_consumer.dart';
import 'package:bein_ecommerce/core/api/end_points.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/country.dart';
import 'package:bein_ecommerce/features/on_boarding/data/models/onboarding.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../core/error/failures.dart';
import '../../../splash/presentation/localization/local_bloc/local_cubit.dart';
import '../models/onboarding.dart';

abstract class CountriesRemoteDataSource {
  Future<Either<Failure, List<CountryModel>>> getAllCountries();

  Future<Either<Failure, List<OnBoarding>>> getOnBoarding();
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  ApiConsumer apiConsumer;

  CountriesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<CountryModel>>> getAllCountries() async {
    String? lang = "";
    await di.sl<LocaleCubit>().getCurrentLang().then((value) {
      lang = value;
      print(' Countries ======================= > lang ============= $value');
    });
    Map<String, dynamic> response = await apiConsumer.get(
        EndPoints.COUNTRIES,
        Options(
          headers: {
            'Accept-Language': lang,
          },
        ));
    if (response['content'] != null) {
      List<dynamic> responseData = response['content'];
      return right(responseData
          .map((country) => CountryModel.fromJson(country))
          .toList());
    }

    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<OnBoarding>>> getOnBoarding() async {
    try {
      Map<String, dynamic> response = await apiConsumer.get(
          EndPoints.getOnBoarding,
          Options(
            headers: {
              'Accept-Language': 'en',
            },
          ));
      List<dynamic> dynamicList = response['onBoarding'];

      return right(dynamicList.map((country) => OnBoarding.fromJson(country)).toList());
    } on Exception catch (e) {
      print(e.toString());
    }

    return Left(ServerFailure());
  }
}
