import 'package:accounting_module/core/http/http_client.dart';
import 'package:accounting_module/models/product_and_service_master.dart';

class ProductAndServiceService {
  static final HttpClient _http = HttpClient();
  static const _baseApiPath =
      '/api/master/product-and-service/v1';

  static Future<List<ProductsAndServiceMaster>> getItems() async {
    try {
      final Map<String, dynamic> response = await _http.get(
        '$_baseApiPath/get-items',
      );
      return (response['data'] as List<dynamic>)
          .map((item) => ProductsAndServiceMaster.fromJson(item))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
