

import 'package:bein_ecommerce/core/error/failures.dart';
import 'package:bein_ecommerce/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../../repository/local/lang_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode: langCode);
}