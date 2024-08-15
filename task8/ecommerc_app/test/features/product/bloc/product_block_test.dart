import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerc_app/core/error/failure.dart';
import 'package:ecommerc_app/features/product/data/models/product_model.dart';
import 'package:ecommerc_app/features/product/domain/entities/product.dart';
import 'package:ecommerc_app/features/product/domain/useCases/create_product.dart';
import 'package:ecommerc_app/features/product/domain/useCases/delete_product.dart';
import 'package:ecommerc_app/features/product/domain/useCases/get_all_products.dart';
import 'package:ecommerc_app/features/product/domain/useCases/get_current_product.dart';
import 'package:ecommerc_app/features/product/domain/useCases/update_product.dart';
import 'package:ecommerc_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late ProductBloc productBloc;
  late MockProductRepository mockProductRepository;
  late GetAllProducts getAllProductsUseCase;
  late GetCurrentProductUseCase getCurrentProductUseCase;
  late CreateProductUseCase createProductUseCase;
  late DeleteProductUseCase deleteProductUseCase;
  late UpdateProductUseCase updateProductUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProductsUseCase = GetAllProducts(mockProductRepository);
    getCurrentProductUseCase = GetCurrentProductUseCase(mockProductRepository);
    createProductUseCase = CreateProductUseCase(mockProductRepository);
    deleteProductUseCase = DeleteProductUseCase(mockProductRepository);
    updateProductUseCase = UpdateProductUseCase(mockProductRepository);
    productBloc = ProductBloc(
      getAllProductsUseCase,
      getCurrentProductUseCase,
      createProductUseCase,
      deleteProductUseCase,
      updateProductUseCase,
    );
  });
  final testProductModel = const ProductEntity(
    id: '123',
    name: 'Test Product',
    description: 'This is a test product',
    price: 19,
    imageUrl: 'https://example.com/product.jpg',
  );


  group('ProductBloc Tests', () {
    blocTest<ProductBloc, ProductState>(
      'emits [ProductInitial, LoadedAllProductState] when LoadAllProductEvent is added and succeeds',
      build: () {
        when(mockProductRepository.getAllProduct())
            .thenAnswer((_) async => Right([testProductModel]));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        ProductInitial(),
        LoadedAllProductState(products: [testProductModel]),
      ],
      verify: (_) {
        verify(mockProductRepository.getAllProduct()).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductInitial, ErrorState] when LoadAllProductEvent is added and fails',
      build: () {
        when(mockProductRepository.getAllProduct())
            .thenAnswer((_) async =>const  Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        ProductInitial(),
        ErrorState(error: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockProductRepository.getAllProduct()).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductInitial, LoadedSingleProductState] when LoadSingleProductEvent is added and succeeds',
      build: () {
        when(mockProductRepository.getCurrentProduct(any))
            .thenAnswer((_) async => Right(testProductModel));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadSingleProductEvent(id: '1')),
      expect: () => [
        ProductInitial(),
        LoadedSingleProductState(product: testProductModel),
      ],
      verify: (_) {
        verify(mockProductRepository.getCurrentProduct('1')).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductInitial, ErrorState] when LoadSingleProductEvent is added and fails',
      build: () {
        when(mockProductRepository.getCurrentProduct(any))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadSingleProductEvent(id: '1')),
      expect: () => [
        ProductInitial(),
        ErrorState(error: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockProductRepository.getCurrentProduct('1')).called(1);
      },
    );

    // Test for updating a product successfully
   blocTest<ProductBloc, ProductState>(
    'emits [ProductInitial, UpdatedProductState] when UpdateProductEvent is added and succeeds',
    build: () {
      when(mockProductRepository.updateProduct(any))
          .thenAnswer((_) async => Right(testProductModel));
      return productBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(product: testProductModel)),
    expect: () => [
      ProductInitial(),
      UpdatedProductState(product: testProductModel),
    ],
    verify: (_) {
      verify(mockProductRepository.updateProduct(testProductModel)).called(1);
    },
  );

  // Test for failing to update a product
  blocTest<ProductBloc, ProductState>(
    'emits [ProductInitial, ErrorState] when UpdateProductEvent is added and fails',
    build: () {
      when(mockProductRepository.updateProduct(any))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(product: testProductModel)),
    expect: () => [
      ProductInitial(),
      ErrorState(error: 'Server Failure'),
    ],
    verify: (_) {
      verify(mockProductRepository.updateProduct(testProductModel)).called(1);
    },
  );

 // Test for deleting a product successfully
  blocTest<ProductBloc, ProductState>(
    'emits [ProductInitial, DeletedProductState] when DeleteProductEvent is added and succeeds',
    build: () {
      when(mockProductRepository.deleteProduct(any))
          .thenAnswer((_) async => const Right(true));
      return productBloc;
    },
    act: (bloc) => bloc.add(DeleteProductEvent(id: '1')),
    expect: () => [
      ProductInitial(),
      const DeletedProductState(message: 'Successfully deleted'),
    ],
    verify: (_) {
      verify(mockProductRepository.deleteProduct('1')).called(1);
    },
  );

  // Test for failing to delete a product
  blocTest<ProductBloc, ProductState>(
    'emits [ProductInitial, ErrorState] when DeleteProductEvent is added and fails',
    build: () {
      when(mockProductRepository.deleteProduct(any))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(DeleteProductEvent(id: '1')),
    expect: () => [
      ProductInitial(),
      ErrorState(error: 'Server Failure'),
    ],
    verify: (_) {
      verify(mockProductRepository.deleteProduct('1')).called(1);
    },
  );

   // Test for creating a product successfully
  blocTest<ProductBloc, ProductState>(
    'emits [ProductInitial, CreatedProductState] when CreateProductEvent is added and succeeds',
    build: () {
      when(mockProductRepository.createProduct(any))
          .thenAnswer((_) async => Right(testProductModel));
      return productBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(product: testProductModel)),
    expect: () => [
      ProductInitial(),
      CreatedProductState(product: testProductModel),
    ],
    verify: (_) {
      verify(mockProductRepository.createProduct(testProductModel)).called(1);
    },
  );

  // Test for failing to create a product
  blocTest<ProductBloc, ProductState>(
    'emits [ProductInitial, ErrorState] when CreateProductEvent is added and fails',
    build: () {
      when(mockProductRepository.createProduct(any))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(product: testProductModel)),
    expect: () => [
      ProductInitial(),
      ErrorState(error: 'Server Failure'),
    ],
    verify: (_) {
      verify(mockProductRepository.createProduct(testProductModel)).called(1);
    },
  );
  });
}
