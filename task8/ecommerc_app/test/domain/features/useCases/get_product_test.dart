import 'package:dartz/dartz.dart';
import 'package:ecommerc_app/core/error/failure.dart';
// import 'package:ecommerc_app/domain/repositories/product_repositories.dart';
import 'package:ecommerc_app/domain/usecases/get_current_product.dart';
import 'package:ecommerc_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

// Create a Mock class for ProductRepository
// class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetCurrentProductUseCase useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = GetCurrentProductUseCase(mockProductRepository);
  });

  final testProduct = const ProductEntity(
    id: 1,
    name: 'Test Product',
    description: 'This is a test product',
    price: 100,
    imageUrl: 'http://test.com/product.jpg',
  );

  const testProductId = 1;

  test('should get product for the name from the repository', () async {
    // Arrange
    when(mockProductRepository.getCurrentProduct(testProductId))
        .thenAnswer((_) async => Right(testProduct));

    // Act
    final result = await useCase.execute(testProductId);

    // Assert
    expect(result, Right(testProduct));
    verify(mockProductRepository.getCurrentProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return a failure when there is an error', () async {
    // Arrange
    when(mockProductRepository.getCurrentProduct(testProductId))
        .thenAnswer((_) async => const Left(ServerFailure('server error')));

    // Act
    final result = await useCase.execute(testProductId);

    // Assert
    expect(result, const Left(ServerFailure('server error')));
    verify(mockProductRepository.getCurrentProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });

  final updatedProduct = const ProductEntity(
    id: 1,
    name: 'Updated Product',
    description: 'This is an updated test product',
    price: 150,
    imageUrl: 'http://test.com/updated_product.jpg',
  );
  
  test('should update product details when product is modified', () async {
    // Arrange
    // First call returns the initial product
    when(mockProductRepository.getCurrentProduct(any))
        .thenAnswer((_) async => Right(testProduct));

    // Act
    final initialResult = await useCase.execute(testProductId);

    // Assert initial state
    expect(initialResult, Right(testProduct));
    verify(mockProductRepository.getCurrentProduct(testProductId));
    
    // Now, update the repository to return the updated product
    when(mockProductRepository.getCurrentProduct(any))
        .thenAnswer((_) async => Right(updatedProduct));

    // Act on the updated state
    final updatedResult = await useCase.execute(testProductId);

    // Assert updated state
    expect(updatedResult, Right(updatedProduct));
    verify(mockProductRepository.getCurrentProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return a failure when update fails', () async {
    // Arrange
    when(mockProductRepository.getCurrentProduct(any))
        .thenAnswer((_) async => const Left(ServerFailure('Update failed')));

    // Act
    final result = await useCase.execute(testProductId);

    // Assert
    expect(result, const Left(ServerFailure('Update failed')));
    verify(mockProductRepository.getCurrentProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
