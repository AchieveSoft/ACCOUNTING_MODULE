import 'package:accounting_module/constants.dart';
import 'package:dio/dio.dart';

class HttpClient {
  late Dio _dioInstance;

  HttpClient() {
    _dioInstance = Dio(
      BaseOptions(baseUrl: Constants.baseUrl),
    ); //[Nil] todo: fix hard code.
  }

  Future<Map<String, dynamic>> get(String url) async =>
      (await _dioInstance.get(url)).data;

  Future<Map<String, dynamic>> post(String url, dynamic data) async =>
      (await _dioInstance.post(url, data: data)).data;

  Future<Map<String, dynamic>> postFormData(
    String url,
    Map<String, dynamic> data,
  ) async => post(url, FormData.fromMap(data));

  Future<Map<String, dynamic>> delete(String url) async =>
      (await _dioInstance.delete(url)).data;
}
