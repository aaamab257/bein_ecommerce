import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../../splash/presentation/localization/local_bloc/local_cubit.dart';
import '../../../products/data/models/product_model.dart';

abstract class AllCategoryRemoteDataSource{
  Future<Either<Failure,List<CategoryItem>>> getAllCategory();
}

class AllCategoryRemoteDataSourceImpl implements AllCategoryRemoteDataSource{
  ApiConsumer apiConsumer;

  AllCategoryRemoteDataSourceImpl({required this.apiConsumer});
  
  @override
  Future<Either<Failure, List<CategoryItem>>> getAllCategory() async {
     try {
       String lang = "";
       await di.sl<LocaleCubit>().getSavedLang().then((value) {
         lang = value;

       });
      Map<String , dynamic> response= await apiConsumer.get(EndPoints.CATEGORIES ,Options(
        headers : {
        'Accept-Language': lang  ,
      },
      ));


      List<dynamic> data = response["content"];

      List<CategoryItem> allCategories = data.map((category) => CategoryItem.fromJson(category)).toList();

      return right(allCategories);


    } on Exception catch (e) {
     print(e.toString());
    }
return Left(ServerFailure());
  }

  
   





}