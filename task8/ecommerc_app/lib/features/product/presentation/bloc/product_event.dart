part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductEvent {
}

class LoadSingleProductEvent extends ProductEvent {
  final String id;

  LoadSingleProductEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  UpdateProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});
  @override
  List<Object> get props => [id];
  
}

class CreateProductEvent extends ProductEvent {
  final ProductEntity product;

  CreateProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}