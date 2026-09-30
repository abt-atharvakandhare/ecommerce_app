import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/product_model.dart';

class ProductDataResource{
  final Dio dio;

  ProductDataResource({required this.dio});
  Future<List<ProductModel>> fetchProducts() async {
    try{
      final response = await dio.get(ApiConstants.products);

      debugPrint(" ");
      debugPrint("PRODUCTS FROM API SUCCESS");
      debugPrint(response.data.toString());

      return (response.data as List)
          .map((item) => ProductModel.fromJSON(item))
          .toList();
    }catch (e){
      debugPrint("PRODUCTS FROM API ERROR: $e");
      throw Exception('Failed to load Products!!!');
    }
  }
}