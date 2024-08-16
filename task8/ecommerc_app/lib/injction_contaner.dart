import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network.dart';
import 'features/product/data/data_sources/local_data_source.dart';
import 'features/product/data/data_sources/remote_data_source.dart';
import 'features/product/data/repositories/product_repository_imp.dart';

import 'features/product/domain/repositories/product_repositories.dart';
import 'features/product/domain/useCases/export_all.dart';

import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //feature: Crud operations on product
  //bloc

  sl.registerFactory(
    () => ProductBloc(
      getProductsUsecase: sl(), 
      getSingleProductUsecase: sl(), 
      createProductUseCase: sl(), 
      deleteProductUsecase: sl(), 
      updateProductUsecase: sl(),
    )
  );

  // usecases
  sl.registerLazySingleton(() => CreateProductUseCase(sl()));
  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => GetCurrentProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  // repository

  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    networkInfo: sl(),
    remoteDatasource: sl(),
    localDatasource: sl(),
  ));

  //data sources

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //!Core
  sl.registerLazySingleton(() => NetworkInfoImpl());

  //external

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
