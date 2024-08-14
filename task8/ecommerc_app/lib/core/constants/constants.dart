class Urls {
  static const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1';
  static String getProductId(int id) => '$baseUrl/$id';
  static String deleteProductId(int id) => '$baseUrl/$id';
  static const String getProducts = '$baseUrl/products';
  static const String addProduct = '$baseUrl/products';
  static String updateProductId(int id) => '$baseUrl/$id';
}