import 'package:equatable/equatable.dart';

abstract class OffersState extends Equatable {
  const OffersState();
}

class OffersInitial extends OffersState {
  @override
  List<Object> get props => [];
}

class OffersLoading extends OffersState {
  @override
  List<Object> get props => [];
}
class OffersSuccess extends OffersState {
  @override
  List<Object> get props => [];
}
class OffersError extends OffersState {
  @override
  List<Object> get props => [];
}
