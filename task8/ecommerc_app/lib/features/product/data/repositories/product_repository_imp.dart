import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repositories.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  
  final ProductRemoteDataSource remoteDatasource;
  final ProductLocalDataSource localDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({required this.networkInfo, required this.remoteDatasource, required this.localDatasource});

  @override
  Future<Either<Failure, ProductModel>> getCurrentProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        var product = await remoteDatasource.getCurrentProduct(id);
        return Right(product);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      try{
        return Right(await localDatasource.getCurrentProduct(id));
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProduct() async {
     if (await networkInfo.isConnected) {
      try{
        var products = await remoteDatasource.getProduct();
        bool isCashed = await localDatasource.cacheProducts(products);
        if(isCashed) {
          return Right(products);
        } else {
          throw const Left(CacheFailure('could not cache the product'));
        }
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      try{
        return Right(await localDatasource.getAllProducts());
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        var updatedProduct = await remoteDatasource.updateProduct(product as ProductModel);
        return Right(updatedProduct);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    }
    return const Left(NoConnection('Network error'));
    
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        bool deletedProduct = await remoteDatasource.deleteProduct(id);
        return Right(deletedProduct);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(NoConnection('Network error'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> createProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        ProductModel newProduct = await remoteDatasource.createProduct(product as ProductModel);
        return Right(newProduct);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(NoConnection('Network error'));
    }
  }

}