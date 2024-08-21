part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class LoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

final class LoadedSingleProductState extends  ProductState {

  final ProductEntity product;

  LoadedSingleProductState({required this.product});

  @override
  List<Object> get props => [product];
}

final class ErrorState extends ProductState {

  final String error;

  ErrorState({required this.error});

  @override
  List<Object> get props => [error];
}


final class LoadedAllProductState extends ProductState {

  final List<ProductEntity> products;

  LoadedAllProductState({required this.products});

  @override
  List<Object> get props => [products];
}

class CreatedProductState extends ProductState{

  final ProductEntity product;
  const CreatedProductState({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdatedProductState extends ProductState{
  final ProductEntity product;
  const UpdatedProductState({ required this.product});

  @override
  List<Object> get props => [product];
  
}

class DeletedProductState extends ProductState {
  final String message;
  const DeletedProductState({required this.message});

  @override
  List<Object> get props => [message];
}