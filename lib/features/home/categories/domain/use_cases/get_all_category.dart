import 'package:bein_ecommerce/features/home/categories/data/models/category_model.dart';
import 'package:bein_ecommerce/features/home/categories/domain/repositories/category_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../data/models/sub_category_model.dart';

class GetAllCategoryUseCase implements UseCase<List<CategoryItem>, NoParams> {
  CategoryRepo categoryRepo;
  GetAllCategoryUseCase({required this.categoryRepo});
  @override
  Future<Either<Failure, List<CategoryItem>>> call(NoParams params) {
    return categoryRepo.getAllCategory();
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> subCategory(int id) {
    return categoryRepo.getAllSubCategory(id);
  }
}
