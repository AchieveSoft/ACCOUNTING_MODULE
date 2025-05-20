import 'package:accounting_module/core/http/http_client.dart';
import 'package:accounting_module/models/quotation.dart';

class QuotationService {
  static final HttpClient _http = HttpClient();
  static const _baseApiPath = '/api/quotation/v1';
  
  static Future<List<Quotation>> getItems() async {
    try {
      final Map<String, dynamic> response = await _http.post('$_baseApiPath/get-quotation', {});
      
      return (response['data'] as List<dynamic>)
        .map((item) => Quotation.fromJson(item))
        .toList();
    } catch (err) {
      rethrow;
    }
  }
}
