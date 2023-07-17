import 'package:dio/dio.dart';

class HomeRepository {

  Future<Response> getHomeData() async {
    final res = await Dio().get('https://student.valuxapps.com/api/home');
    return res;
  }

  Future<dynamic> getCategories() async {
    final res = await Dio().get('https://student.valuxapps.com/api/categories');

    return res.data;
  }

}
