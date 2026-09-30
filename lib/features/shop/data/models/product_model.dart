import '../../domain/entities/product.dart';

class ProductModel extends Product{
  ProductModel({
    required int id,
    required String title,
    required double price,
    double? originalPrice,
    required String description,
    required String image,
    required String volume,
}):super(
    id: id,
    title: title,
    price: price,
    originalPrice: originalPrice,
    description: description,
    image: image,
    volume: volume,
  );
  factory ProductModel.fromJSON(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      price: (json['price'] as num). toDouble(),
      originalPrice: json['originalPrice'] != null ? (json['originalPrice'] as num).toDouble() : (json['price'] as num).toDouble() * 1.25,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      volume: json['volume'] ?? '1 Piece'
    );
  }
}