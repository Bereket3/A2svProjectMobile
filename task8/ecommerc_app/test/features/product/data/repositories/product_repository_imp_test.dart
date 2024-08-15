
import 'package:dartz/dartz.dart';
import 'package:ecommerc_app/core/error/exception.dart';
import 'package:ecommerc_app/core/error/failure.dart';
import 'package:ecommerc_app/features/product/data/models/product_model.dart';
import 'package:ecommerc_app/features/product/data/repositories/product_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockProductRemoteDatasource;
  late MockNetworkInfoImpl mockNetworkInfo;
  late MockProductLocalDataSource mockProductLocalDatasource;
  late ProductRepositoryImpl repository;

  setUp((){
    mockProductRemoteDatasource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfoImpl();
    mockProductLocalDatasource = MockProductLocalDataSource();
    repository = ProductRepositoryImpl(
      remoteDatasource: mockProductRemoteDatasource,
      networkInfo: mockNetworkInfo,
      localDatasource: mockProductLocalDatasource,
    );
  });

  void runOnlineTests(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runOffineTests(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getProduct', (){
    const products = [
      ProductModel(
        id:  '66bc7fd34a74f6cc9351de67',
        name: 'Test Product',
        description: 'This is a test product',
        price: 100,
        imageUrl: 'http://test.com/product.jpg',
      ),
      ProductModel(
        id:  '66bc7fd34a74f6cc9351de68',
        name: 'Test Product 2',
        description: 'This is a test product',
        price: 100,
        imageUrl: 'http://test.com/product.jpg',
      ),
    ];

    runOnlineTests(() {
      test('should return remote data when the remote data call is success', () async {
        // arrange
        when(mockProductLocalDatasource.cacheProducts(any)).thenAnswer((_) async => true);
        when(mockProductRemoteDatasource.getProduct()).thenAnswer((_) async => products);
        // act
        var result = await repository.getAllProduct();
        // assert
        expect(result, const Right(products));
        verify(mockProductRemoteDatasource.getProduct());
      });
      
      test('should cache the latest remote data when the remote data call is success', () async {
        // arrange
        when(mockProductLocalDatasource.cacheProducts(any)).thenAnswer((_) async => true);
        when(mockProductRemoteDatasource.getProduct()).thenAnswer((_) async => products);
        // act
        bool result = await repository.localDatasource.cacheProducts(products);
        // assert
        expect(result, true);
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductLocalDatasource.cacheProducts(any)).thenAnswer((_) async => true);
        when(mockProductRemoteDatasource.getProduct()).thenThrow(ServerException());
        // act
        var result = await repository.getAllProduct();
        // assert
        verify(mockProductRemoteDatasource.getProduct());
        verifyZeroInteractions(mockProductLocalDatasource);
        expect(result, const Left(ServerFailure('Server Failure')));
      });

    });

    runOffineTests((){
      test('should get local data when there is cached data', () async {
        
        // arrange
        when(mockProductLocalDatasource.cacheProducts(any)).thenAnswer((_) async => true);
        when(mockProductLocalDatasource.getAllProducts()).thenAnswer((_) async => products);
        // act
        var result = await repository.getAllProduct();
        // assert
        verify(mockProductLocalDatasource.getAllProducts());
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Right(products));
      });

      test('should throw CacheFailure when there is no cached data', () async {
        // arrange
        when(mockProductLocalDatasource.cacheProducts(any)).thenAnswer((_) async => true);
        when(mockProductLocalDatasource.getAllProducts()).thenThrow(CacheException());
        // act
        var result = await repository.getAllProduct();
        // assert
        verify(mockProductLocalDatasource.getAllProducts());
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(CacheFailure('Cache Failure')));
      });

    });
  });
  group('getSingleProduct', (){
    const product = ProductModel(
      id:  '66bc7fd34a74f6cc9351de67',
      name: 'Test Product',
      description: 'This is a test product',
      price: 100,
      imageUrl: 'http://test.com/product.jpg',
    );

    const id = '66bc7fd34a74f6cc9351de67';
    

    runOnlineTests(() {
      test('should return remote data when the remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.getCurrentProduct(id)).thenAnswer((_) async => product);
        // act
        var result = await repository.getCurrentProduct(id);
        // assert
        expect(result, const Right(product));
        verify(mockProductRemoteDatasource.getCurrentProduct(id));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.getCurrentProduct(id)).thenThrow(ServerException());
        // act
        var result = await repository.getCurrentProduct(id);
        // assert
        verify(mockProductRemoteDatasource.getCurrentProduct(id));
        verifyZeroInteractions(mockProductLocalDatasource);
        expect(result, const Left(ServerFailure('Server Failure')));
      });

    });

    runOffineTests((){

      test('should get local data when the requested data is cached', () async {
        when(mockProductLocalDatasource.getCurrentProduct(id)).thenAnswer((_) async => product);
        // act
        var result = await repository.getCurrentProduct(id);
        // assert
        verify(mockProductLocalDatasource.getCurrentProduct(id));
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Right(product));
      });

      test('should throw CacheFailure when there is no cached data', () async {
        // arrange
        when(mockProductLocalDatasource.cacheProducts(any)).thenAnswer((_) async => true);
        when(mockProductLocalDatasource.getAllProducts()).thenAnswer((_) async => const [
          ProductModel(
            id:  '66bc7fd34a74f6cc9351de67',
            name: 'Test Product',
            description: 'This is a test product',
            price: 100,
            imageUrl: 'http://test.com/product.jpg',
          ),
          ProductModel(
            id:  '66bc7fd34a74f6cc9351de68',
            name: 'Test Product 2',
            description: 'This is a test product',
            price: 100,
            imageUrl: 'http://test.com/product.jpg',
          ),
        ]);
        when(mockProductLocalDatasource.getCurrentProduct(id)).thenThrow(CacheException());
        // act
        var result = await repository.getCurrentProduct(id);
        // assert
        verify(mockProductLocalDatasource.getCurrentProduct(id));
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(CacheFailure('Cache Failure')));
      });

    });
  });
  
  group('updateProduct', (){
    const product = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100,
      imageUrl: 'image1.jpg',
    );  

    runOnlineTests(() {
      test('should return remote data when the remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.updateProduct(product)).thenAnswer((_) async => product);
        // act
        var result = await repository.updateProduct(product);
        // assert
        expect(result, const Right(product));
        verify(mockProductRemoteDatasource.updateProduct(product));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.updateProduct(product)).thenThrow(ServerException());
        // act
        var result = await repository.updateProduct(product);
        // assert
        verify(mockProductRemoteDatasource.updateProduct(product));
        expect(result, const Left(ServerFailure('Server Failure')));
      });
    });

    runOffineTests((){
      test('should throw failure if no connection', () async {
        // act
        var result = await repository.updateProduct(product);
        // assert
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(NoConnection('Network error')));
      });
    });
  });
  
  group('deleteProduct', (){
    const id = '1';

    runOnlineTests(() {
      test('should should delete the data when remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.deleteProduct(id)).thenAnswer((_) async => true);
        // act
        var result = await repository.deleteProduct(id);
        // assert
        expect(result, const Right(true));
        verify(mockProductRemoteDatasource.deleteProduct(id));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.deleteProduct(id)).thenThrow(ServerException());
        // act
        var result = await repository.deleteProduct(id);
        // assert
        verify(mockProductRemoteDatasource.deleteProduct(id));
        expect(result, const Left(ServerFailure('Server Failure')));
      });
    });

    runOffineTests((){
      test('should throw failure if no connection', () async {
        // act
        var result = await repository.deleteProduct(id);
        // assert
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(NoConnection('Network error')));
      });
    });
  });
  
  group('addProduct', (){
    const product = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100,
      imageUrl: 'image1.jpg',
    );

    runOnlineTests(() {
      test('should should return the new data when remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.createProduct(product)).thenAnswer((_) async => product);
        // act
        var result = await repository.createProduct(product);
        // assert
        expect(result, const Right(product));
        verify(mockProductRemoteDatasource.createProduct(product));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.createProduct(product)).thenThrow(ServerException());
        // act
        var result = await repository.createProduct(product);
        // assert
        verify(mockProductRemoteDatasource.createProduct(product));
        expect(result, const Left(ServerFailure('Server Failure')));
      });
    });

    runOffineTests((){
      test('should throw failure if no connection', () async {
        // act
        var result = await repository.createProduct(product);
        // assert
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(NoConnection('Network error')));
      });
    });
  });
}