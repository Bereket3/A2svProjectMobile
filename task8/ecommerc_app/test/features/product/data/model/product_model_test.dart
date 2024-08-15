import 'dart:convert';

import 'package:ecommerc_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helpers/json_parser.dart';

void main () {
  const testProductModel = ProductModel(
    id: '66bc7fd34a74f6cc9351de67',
    name: 'shoe',
    description: 'testwith image',
    price: 11,
    imageUrl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723629523/images/kwocoxxfwbllfi1lqci1.png'
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
        readJson('dummy_product_response.json'),
      );

      //act
      final result = ProductModel.fromJson(jsonMap);
      expect(result, isA<ProductModel>());
    }
  );
  test(
    'should return a json map containing proper data',
    () async {

      // act
      final result = testProductModel.toJson();

      // assert
      final expectedJsonMap = {
          'id': '66bc7fd34a74f6cc9351de67',
          'name': 'shoe',
          'description': 'testwith image',
          'price': 11,
          'imageUrl': 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723629523/images/kwocoxxfwbllfi1lqci1.png'
      };
      expect(result, equals(expectedJsonMap));

    },
  );
}