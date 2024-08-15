import 'package:ecommerc_app/core/constants/constants.dart';
import 'package:ecommerc_app/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerc_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../helpers/json_parser.dart';
import '../../../../helpers/test_helper.mocks.dart';


void main () {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl remoteDataSource;
  final String id = '66bc7fd34a74f6cc9351de67';

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });group(
    'get product',
    () {
      test(
        'should return product model when 200 status code', 
        () async {
          when(
            mockHttpClient.get(
              Uri.parse(Urls.getProductId(id))
            )
          ).thenAnswer(
            (_) async => http.Response(
              readJson('dummy_product_response.json'),
              200
            )
          );
          final result = await remoteDataSource.getCurrentProduct(id);
          expect(result, isA<ProductModel>());
        }
      );
    }
  );

}