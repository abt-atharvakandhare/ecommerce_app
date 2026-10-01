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

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;


  @override
  int get hashCode => id.hashCode;

}

class CartItem{
  final Product product;
  int quantity;

  CartItem({
   required this.product,
   this.quantity=1,
});
}