import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repositories.dart';

class GetCurrentProductUseCase {

  final ProductRepository productRepository;

  GetCurrentProductUseCase(this.productRepository); 
  
  Future<Either<Failure, ProductEntity>> execute(int id) {
    return productRepository.getCurrentProduct(id);
  }

}