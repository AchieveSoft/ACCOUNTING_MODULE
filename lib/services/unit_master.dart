import 'package:accounting_module/core/http/http_client.dart';
import 'package:accounting_module/models/requests/unit_master.dart';
import 'package:accounting_module/models/responses/base_response.dart';
import 'package:accounting_module/models/responses/unit_master.dart';

class UnitMasterService {
  static final HttpClient _http = HttpClient();

  static Future<List<UnitMasterResponseData>> getData() async {
    try {
      final Map<String, dynamic> response = await _http.post('/api/master/unit/v1/get-items', {});
      
      if (response['success'] == true) {
        return (response['data'] as List<dynamic>)
            .map((item) => UnitMasterResponseData.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<BaseResponse<String>> createUnit(UnitMasterRequest req) async {
    try {
        final Map<String, dynamic> response = await _http.post('/api/master/unit/v1/create', req.toJson());
        return BaseResponse.fromJson(response);
    } catch (err) {
      rethrow;
    }
  }

  static Future<BaseResponse<String>> deleteUnit(String unitCode) async {
    try {
        final Map<String, dynamic> response = await _http.delete('/api/master/unit/v1/delete/$unitCode');
        return BaseResponse.fromJson(response);
    } catch (err) {
      rethrow;
    }
  }
}
