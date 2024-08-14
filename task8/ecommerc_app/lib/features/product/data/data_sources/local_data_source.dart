import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<bool> cacheProducts(List<ProductModel> products);
  Future getAllProducts();
  Future getCurrentProduct(String id);
}


class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  
  @override
  Future<bool> cacheProducts(List<ProductModel> products)async {
    /// Encode all current products and set them in local storage
    return await sharedPreferences.setString('PRODUCTS', jsonEncode(products));
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final jsonString = sharedPreferences.getString('PRODUCTS');
    if (jsonString != null) {
      final List<dynamic> jsonDecoded = jsonDecode(jsonString);
      final products = jsonDecoded.map((product) {
        return ProductModel.fromJson(product);
      }).toList();
      return products;
    } else {
      throw CacheException();
    }
  }
  
  @override
  Future getCurrentProduct(String id)async {
    List<ProductModel> products = await this.getAllProducts();
    if(products.isEmpty) {
      return null;
    }
    for (var item in products) {
      if(item.id == id) {
        return item;
      }
    }
  }
}