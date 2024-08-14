import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
      required int id,
      required String name,
      required String description,
      required int price,
      required String imageUrl,
  }) : super(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
  );

  factory ProductModel.fromJson(Map < String, dynamic > json) => ProductModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    price: json['price'],
    imageUrl: json['imageUrl'],
  );
}