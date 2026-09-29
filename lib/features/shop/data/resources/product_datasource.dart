import 'package: dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/product_model.dart';

class ProductDataResource{
  final Dio dio;

  ProductDataResource({required this.dio});
  Future<List><ProductModel>> fetchProducts() async {
    try{
      final response = await dio.get(ApiConstants.products);
      return (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    }catch (e){
      throw Exception('Failed to load Products!!!');
    }
  }
}