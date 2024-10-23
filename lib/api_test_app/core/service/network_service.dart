import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response> get(String url);
  Future<Response> post(String url, dynamic body);
}

class NetworkServiceImpl implements NetworkService {
  final dio = Dio();
  @override
  Future<Response> get(String url) async {
    final respose = await dio.get(url);
    return respose;
  }

  @override
  Future<Response> post(String url, body) async {
    final response = await dio.post(url, data: body);
    return response;
  }
}
