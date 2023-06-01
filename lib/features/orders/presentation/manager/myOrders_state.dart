
import 'package:equatable/equatable.dart';

abstract class MyOrdersState extends Equatable{
  const MyOrdersState() ;
}

class MyOrdersInitial extends MyOrdersState {
  @override
  List<Object> get props => [];
}

class MyOrdersLoading extends MyOrdersState {
  @override
  List<Object> get props => [];
}
class MyOrdersSuccess extends MyOrdersState {
  @override
  List<Object> get props => [];
}

class MyOrdersError extends MyOrdersState {
  @override
  List<Object> get props => [];
}