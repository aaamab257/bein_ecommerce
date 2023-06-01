import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String? errorMSG;
  ServerFailure({this.errorMSG});
}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}