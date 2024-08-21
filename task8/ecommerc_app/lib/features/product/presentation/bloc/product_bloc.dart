import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/useCases/export_all.dart';

part 'product_event.dart';
part 'product_state.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getProductsUsecase;
  final GetCurrentProductUseCase getSingleProductUsecase;
  final CreateProductUseCase createProductUseCase;
  final DeleteProductUseCase deleteProductUsecase;
  final UpdateProductUseCase updateProductUsecase;
  
  ProductBloc({
    required this.getProductsUsecase, 
    required this.getSingleProductUsecase, 
    required this.createProductUseCase, 
    required this.deleteProductUsecase, 
    required this.updateProductUsecase
  }) : super(ProductInitial()) {

    on<LoadAllProductEvent>((event, emit) async {
      emit(ProductInitial());

      final result = await getProductsUsecase.execute();
      result.fold(
        (failure) => emit(ErrorState(error: failure.message)),
        (products) => emit(LoadedAllProductState(products: products)),
      );
    });

    on<LoadSingleProductEvent>((event, emit) async {
      emit(ProductInitial());

      final result = await getSingleProductUsecase.execute(event.id);
      result.fold(
        (failure) => emit(ErrorState(error: failure.message)),
        (product) => emit(LoadedSingleProductState(product: product)),
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(ProductInitial());

      final result = await updateProductUsecase.execute(event.product);
      result.fold(
        (failure) => emit(ErrorState(error: failure.message)),
        (product) => emit(UpdatedProductState(product: product)),
      );
    });

    on<CreateProductEvent>((event, emit) async {
      emit(ProductInitial());

      final result = await createProductUseCase.execute(event.product);
      result.fold(
        (failure) => emit(ErrorState(error: failure.message)),
        (product) => emit(CreatedProductState(product: product)),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductInitial());

      final result = await deleteProductUsecase.execute(event.id);
      result.fold(
        (failure) => emit(ErrorState(error: failure.message)),
        (product) => emit(const DeletedProductState(message: 'Successfully deleted')),
      );
    });

  }
}