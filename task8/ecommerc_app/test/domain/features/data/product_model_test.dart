import 'dart:convert';

import 'package:ecommerc_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/json_parser.dart';

void main () {
  const testProductModel = ProductModel(
    id: 1, 
    name: 'test', 
    description: 'these is test modle', 
    price: 100, 
    imageUrl: 'http://test.com/test.jpg'
  );

  test(
    'these should return a product model', 
    () async {
      expect(testProductModel, isA<ProductModel>());
    }
  );

  test(
    'sould return product model form the json',
    () async {
      //arrange
      final Map < String, dynamic > jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_product_response.json'),
      );

      //act
      final result = ProductModel.fromJson(jsonMap);
      expect(result, equals(testProductModel));
    }
  );
}