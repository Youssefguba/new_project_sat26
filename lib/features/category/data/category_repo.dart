import 'package:dio/dio.dart';

class CategoryRepo {

  Future<dynamic> getCategoryDetails(int id) async {
    final res = await Dio().get('https://student.valuxapps.com/api/categories/${id}');
    return res.data;
  }
}