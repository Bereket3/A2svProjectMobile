import 'package:ecommerc_app/features/product/domain/repositories/product_repositories.dart';
import 'package:http/http.dart' as http;
//import 'package:ecommerc_app/domain/usecases/get_current_product.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks(
  [
   ProductRepository,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() {}