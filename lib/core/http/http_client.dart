import 'package:dio/dio.dart';

class HttpClient {
  late Dio _dioInstance;

  HttpClient() {
    // _dioInstance = Dio(BaseOptions(baseUrl: 'http://180.180.156.134:8080')); //[Nil] todo: fix hard code.
    _dioInstance = Dio(BaseOptions(baseUrl: 'http://localhost:8080')); //[Nil] todo: fix hard code.
  }

  Future<Map<String, dynamic>> get(String url) async =>
      (await _dioInstance.get(url)).data;

  Future<Map<String, dynamic>> post(String url, dynamic data) async =>
      (await _dioInstance.post(url, data: data)).data;

  Future<Map<String, dynamic>> delete(String url) async =>
      (await _dioInstance.delete(url)).data;
}
