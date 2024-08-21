class Urls {
  static const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1';
  static String getProductId(String id) => '$baseUrl/products/$id';
  static String deleteProductId(String id) => '$baseUrl/$id';
  static const String getProducts = '$baseUrl/products/';
  static String updateProductId(String id) => '$baseUrl/products/$id';
}