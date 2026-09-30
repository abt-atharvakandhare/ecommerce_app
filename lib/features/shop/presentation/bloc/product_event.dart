import 'package:ecommerce_app/features/shop/domain/entities/product.dart';

abstract class ProductEvent{}

class FetchProductsEvents extends ProductEvent{}

class AddToCartEvent extends ProductEvent{
  final Product product;
  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends ProductEvent{
  final Product product;
  RemoveFromCartEvent(this.product);
}