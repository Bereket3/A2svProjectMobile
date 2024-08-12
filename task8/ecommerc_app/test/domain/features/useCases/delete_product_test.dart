import 'package:dartz/dartz.dart';
import 'package:ecommerc_app/core/error/failure.dart';
import 'package:ecommerc_app/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProductUseCase deleteUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteUseCase = DeleteProductUseCase(mockProductRepository);
  });

  const testProductId = 1;

  test('should delete product from the repository', () async {
    // Arrange
    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async =>const Right(true));

    // Act
    final result = await deleteUseCase.execute(testProductId);

    // Assert
    expect(result, const Right(true));
    verify(mockProductRepository.deleteProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should return a failure when delete fails', () async {
    // Arrange
    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async => const Left(ServerFailure('Delete failed')));

    // Act
    final result = await deleteUseCase.execute(testProductId);

    // Assert
    expect(result, const Left(ServerFailure('Delete failed')));
    verify(mockProductRepository.deleteProduct(testProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
