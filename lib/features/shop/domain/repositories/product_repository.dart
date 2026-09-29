import '../../data/resources/product_datasource.dart';
import '../entities/product.dart';

class ProductRepository{
  final ProductDataResource datasource;

  ProductRepository({required this.datasource});

  Future<List<Product>> getProducts() async{
    return await datasource.fetchProducts();
  }
}