import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  List<Object> get props => [];
}
class ProductsSuccess extends ProductsState {
  @override
  List<Object> get props => [];
}
class ProductsError extends ProductsState {
  @override
  List<Object> get props => [];
}



class GetProductSelectionLoading extends ProductsState {
  @override
  List<Object> get props => [];
}
class GetProductSelectionSuccess extends ProductsState {
  @override
  List<Object> get props => [];
}

class GetProductSelectionError extends ProductsState {
  @override
  List<Object> get props => [];
}