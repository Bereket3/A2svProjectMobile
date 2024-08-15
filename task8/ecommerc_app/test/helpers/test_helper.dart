import 'package:ecommerc_app/core/network/network.dart';
import 'package:ecommerc_app/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerc_app/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerc_app/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerc_app/features/product/domain/useCases/export_all.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';


@GenerateMocks(
  [
   ProductRepository,
   ProductRemoteDataSource,
   ProductLocalDataSource,
   SharedPreferences,
   InternetConnectionChecker,
   NetworkInfoImpl,
   GetAllProducts,
   GetCurrentProductUseCase,

  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() {}