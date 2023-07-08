import 'package:dio/dio.dart';

class HomeRepository {

  Future<dynamic> getHomeData() async {
    final res = await Dio().get('https://student.valuxapps.com/api/home');
    return res;
  }

}
