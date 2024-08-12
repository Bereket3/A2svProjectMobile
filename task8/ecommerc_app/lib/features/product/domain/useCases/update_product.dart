import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repositories.dart';

class UpdateProductUseCase {

  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository); 
  
  Future<Either<Failure, ProductEntity>> execute(ProductEntity product) {
    return productRepository.updateProduct(product);
  }

}