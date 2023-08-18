import 'package:dio/dio.dart';
import 'package:new_project_sat26/features/product/models/product_model.dart';

class ProductRepo {
  Future<ProductModel?> getProductById(int id) async {
    try {
      final response =
          await Dio().get('https://student.valuxapps.com/api/products/$id');

      return ProductModel.fromJson(response.data['data']);
    } catch (e) {
      throw e;
    }
  }
}
