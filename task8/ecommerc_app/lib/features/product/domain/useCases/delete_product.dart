import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/product_repositories.dart';

class DeleteProductUseCase {

  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository); 
  
  Future<Either<Failure, bool>> execute(String id) {
    return productRepository.deleteProduct(id);
  }

}