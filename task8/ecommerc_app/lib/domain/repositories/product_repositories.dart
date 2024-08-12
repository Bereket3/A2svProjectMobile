import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  
  Future<Either<Failure, ProductEntity>> getCurrentProduct(int id);
  Future<Either<Failure, ProductEntity>> createProduct(ProductEntity product);
  Future<Either<Failure, bool>> deleteProduct(int id);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  
}