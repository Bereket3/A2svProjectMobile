import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repositories.dart';

class GetAllProducts {

  final ProductRepository productRepository;

  GetAllProducts(this.productRepository); 
  
  Future<Either<Failure, List<ProductEntity>>> execute() {
    return productRepository.getAllProduct();
  }

}