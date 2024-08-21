import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/product.dart';
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
      throw new Exception('could not convert to string');
    }
    final response = await client.get(Uri.parse(Urls.getProductId(id)));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } 
    throw ServerException();

  }
  
  @override
  Future<List<ProductModel>> getProduct() async {
    final response = await client.get(Uri.parse(Urls.getProducts));

    if (response.statusCode == 200) {
      List<dynamic> result = await jsonDecode(response.body)['data'];
      final products = await result.map((product) => ProductModel.fromJson(product)).toList();
      return products;
    }
    throw ServerException();
    
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    // final response = await client.put(
    //   Uri.parse(Urls.getProductId(product.id)),
    //   body: jsonEncode({
    //     'name': product.name,
    //     'description': product.description,
    //     'price': product.price,
    //   }),
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // if (response.statusCode == 200) {
    //   return ProductModel.fromJson(json.decode(response.body)['data']);
    // } else {
    //   throw ServerException();
    // }

    var request = http.MultipartRequest('put', Uri.parse(Urls.getProductId(product.id)));

    request.fields['name'] = product.name;
    request.fields['price'] = product.price.toString();
    request.fields['description'] = product.description;
    
    var pic = await http.MultipartFile.fromPath('image', product.imageUrl, contentType: MediaType('image', 'jpg'));
    request.files.add(pic);
    var response = await request.send();
    print(response.statusCode); print(product.id);
    if (response.statusCode == 200 || response.statusCode == 204){
      var jsonResult = await http.Response.fromStream(response);
      var product = json.decode(jsonResult.body)['data'];
      
      return ProductModel.fromJson(product);
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future deleteProduct(dynamic id) async {
    try {
    id = id.toString();
    } catch (e) {
      throw new Error();
    }
    final response = await client.delete(Uri.parse(Urls.getProductId(id)));
    if (response.statusCode == 200) {
      return true;
    } 
    throw ServerException();
    
  }
  
  @override
  Future<ProductModel> createProduct(ProductEntity product) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.getProducts));

    request.fields['name'] = product.name;
    request.fields['price'] = product.price.toString();
    request.fields['description'] = product.description;
    
    var pic = await http.MultipartFile.fromPath('image', product.imageUrl, contentType: MediaType('image', 'jpg'));
    request.files.add(pic);
    // print(pic.filename);
    var response = await request.send();

    if (response.statusCode == 201){
      var jsonResult = await http.Response.fromStream(response);
      var product = json.decode(jsonResult.body)['data'];
      
      return ProductModel.fromJson(product);
    } else {
      throw ServerException();
    }
  }
  
}