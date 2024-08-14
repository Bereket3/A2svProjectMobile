import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';


abstract class ProductRemoteDataSource {
  
  Future<ProductModel> getCurrentProduct(String id);
  Future<List<ProductModel>> getProduct();
  Future<ProductModel> updateProduct(ProductModel product);
  Future deleteProduct(String id);
  Future createProduct(ProductModel product);

}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  
   @override
  Future < ProductModel > getCurrentProduct(dynamic id) async {
    try {
    id = id.toString();
    } catch (e) {
      throw new Error();
    }
    final response = await client.get(Uri.parse(Urls.getProductId(id)));

     if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } 
    throw ServerException();

  }
  
  @override
  Future<List<ProductModel>> getProduct() async {
    final response = await client.get(Uri.parse(Urls.getProducts));

    List<dynamic> result = jsonDecode(response.body)['data'];
    final products = result.map((product) => ProductModel.fromJson(product)).toList();

    if (response.statusCode == 200) {
      return products;
    }
    throw ServerException();
    
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await client.put(
        Uri.parse(Urls.updateProductId(product.id)),
        body: product.toJson());

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } 
    throw ServerException();
    
  }
  
  @override
  Future deleteProduct(dynamic id) async {
    try {
    id = id.toString();
    } catch (e) {
      throw new Error();
    }
    final response = await client.delete(Uri.parse(Urls.deleteProductId(id)));

    if (response.statusCode == 200) {
      return true;
    } 
    throw ServerException();
    
  }
  
  @override
  Future createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(Urls.addProduct),
      body: product.toJson(),
    );
    if(response == 200){
      return ProductModel.fromJson(jsonDecode(response.body)['data']);
    }
    throw ServerException();
  }
  
}