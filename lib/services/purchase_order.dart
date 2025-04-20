import 'package:accounting_module/core/http/http_client.dart';
import 'package:accounting_module/models/purchase_order.dart';
import 'package:accounting_module/models/responses/base_response.dart';

class PurchaseOrderService {
  static final HttpClient _http = HttpClient();

  static Future<BaseResponse<String>> create(PurchaseOrder data) async {
    try {
      final Map<String, dynamic> response = await _http.post('/api/purchase-order/v1/create', data.toJson());
      return BaseResponse.fromJson(response);
    } catch (err) {
      rethrow;
    }
  }
}