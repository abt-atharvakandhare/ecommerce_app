class Product{
  final int id;
  final String title;
  final double price;
  final double? originalPrice;
  final String description;
  final String image;
  final String volume;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.description,
    required this.image,
    required this.volume,
});
}