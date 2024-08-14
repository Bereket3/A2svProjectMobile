import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future cacheProducts(List<ProductModel> products);
  Future getAllProducts();

}


class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  
  @override
  Future<bool> cacheProducts(List<ProductModel> products) {
    /// Encode all current products and set them in local storage
    return sharedPreferences.setString('PRODUCTS', jsonEncode(products));
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
}