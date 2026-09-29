import '../../domain/entities/product.dart';

class ProductModel extends Product{
  ProductMode({
    required int id,
    required String title,
    required double price,
    required String description,
    required String image,
}):super(
    id: id,
    title: title,
    price: price,
    description: description,
    image: image,
  );
  factory ProductModel.fromJSON(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      price: (json['price'] as num). toDouble(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    )
  }
}