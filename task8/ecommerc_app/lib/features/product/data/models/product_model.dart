import '../../domain/entities/product.dart';

extension ProductMapper on ProductEntity {
  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }
}


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

  Map < String, dynamic > toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl' :imageUrl,
  };

  ProductEntity toProductEntity() => ProductEntity(
    id: id,
    name: name,
    description: description,
    price: price,
    imageUrl: imageUrl,
  );

  static List<ProductEntity> toProductListEntity(List<ProductModel> model) {
    return model.map((product) => product.toProductEntity()).toList();
  }
}