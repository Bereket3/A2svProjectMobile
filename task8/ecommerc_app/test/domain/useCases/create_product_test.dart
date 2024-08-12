import 'package:dartz/dartz.dart';
import 'package:ecommerc_app/core/error/failure.dart';
import 'package:ecommerc_app/domain/entities/product.dart';
import 'package:ecommerc_app/domain/useCases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';



void main() {
  late CreateProductUseCase insertUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    insertUseCase = CreateProductUseCase(mockProductRepository);
  });

  final testProduct = const ProductEntity(
    id: 1,
    name: 'Test Product',
    description: 'This is a test product',
    price: 100,
    imageUrl: 'http://test.com/product.jpg',
  );

  test('should insert product into the repository', () async {
    // Arrange
    when(mockProductRepository.createProduct(testProduct))
        .thenAnswer((_) async => Right(testProduct));

    // Act
    final result = await insertUseCase.execute(testProduct);

    // Assert
    expect(result, Right(testProduct));
    verify(mockProductRepository.createProduct(testProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return a failure when insert fails', () async {
    // Arrange
    when(mockProductRepository.createProduct(testProduct))
        .thenAnswer((_) async => const Left(ServerFailure('Insert failed')));

    // Act
    final result = await insertUseCase.execute(testProduct);

    // Assert
    expect(result, const Left(ServerFailure('Insert failed')));
    verify(mockProductRepository.createProduct(testProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
