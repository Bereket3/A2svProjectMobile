import 'package:dartz/dartz.dart';
import 'package:ecommerc_app/core/error/failure.dart';
import 'package:ecommerc_app/domain/entities/product.dart';
import 'package:ecommerc_app/domain/useCases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

// Create a Mock class for ProductRepository
// class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late UpdateProductUseCase useCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    useCase = UpdateProductUseCase(mockProductRepository);
  });

  final testProduct = const ProductEntity(
    id: 1,
    name: 'Test Product',
    description: 'This is a test product',
    price: 100,
    imageUrl: 'http://test.com/product.jpg',
  );


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
    when(mockProductRepository.updateProduct(any))
        .thenAnswer((_) async => Right(testProduct));

    // Act
    final initialResult = await useCase.execute(testProduct);

    // Assert initial state
    expect(initialResult, Right(testProduct));
    verify(mockProductRepository.updateProduct(testProduct));
    
    // Now, update the repository to return the updated product
    when(mockProductRepository.updateProduct(any))
        .thenAnswer((_) async => Right(updatedProduct));

    // Act on the updated state
    final updatedResult = await useCase.execute(testProduct);

    // Assert updated state
    expect(updatedResult, Right(updatedProduct));
    verify(mockProductRepository.updateProduct(testProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return a failure when update fails', () async {
    // Arrange
    when(mockProductRepository.updateProduct(any))
        .thenAnswer((_) async => const Left(ServerFailure('Update failed')));

    // Act
    final result = await useCase.execute(testProduct);

    // Assert
    expect(result, const Left(ServerFailure('Update failed')));
    verify(mockProductRepository.updateProduct(testProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
