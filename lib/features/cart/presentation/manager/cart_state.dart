import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}
class CartSuccess extends CartState {
  @override
  List<Object> get props => [];
}
class CartError extends CartState {
  @override
  List<Object> get props => [];
}

class CartDecreaseSuccess extends CartState {
  @override
  List<Object> get props => [];
}

class CartIncreaseSuccess extends CartState {
  @override
  List<Object> get props => [];
}

class CartProductLoading extends CartState {
  @override
  List<Object> get props => [];
}





