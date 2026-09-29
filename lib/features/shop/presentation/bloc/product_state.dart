import '../../domain/entities/product.dart';

abstract class ProductState{}

class ProductInitialState extends ProductState{}

class ProductLoadingState extends ProductState{}

class ProductLoadedState extends ProductState{
  final List<Product> products;
  final List<Product> cartItems;

  ProductLoadedState({required this.products, required this.cartItems});

}

class ProductErrorState extends ProductState{
  final String msg;
  ProductErrorState(this.msg);
}