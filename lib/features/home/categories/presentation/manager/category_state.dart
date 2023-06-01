import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}
class CategorySuccess extends CategoryState {
  @override
  List<Object> get props => [];
}
class CategoryError extends CategoryState {
  @override
  List<Object> get props => [];
}



class GetCategorySelectionLoading extends CategoryState {
  @override
  List<Object> get props => [];
}
class GetCategorySelectionSuccess extends CategoryState {
  @override
  List<Object> get props => [];
}

class GetCategorySelectionError extends CategoryState {
  @override
  List<Object> get props => [];
}