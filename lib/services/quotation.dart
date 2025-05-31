import 'package:accounting_module/core/http/http_client.dart';
import 'package:accounting_module/models/quotation.dart';
import 'package:accounting_module/models/requests/data_and_file.dart';
import 'package:accounting_module/models/responses/base_response.dart';

class QuotationService {
  static final HttpClient _http = HttpClient();
  static const _baseApiPath = '/api/quotation/v1';

  static Future<List<Quotation>> getItems() async {
    try {
      final Map<String, dynamic> response = await _http.post(
        '$_baseApiPath/get-quotation',
        {},
      );

      return (response['data'] as List<dynamic>)
          .map((item) => Quotation.fromJson(item))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  static Future<BaseResponse<String>> create(Quotation data) async {
    try {
      final Map<String, dynamic> response = await _http.postFormData(
        '$_baseApiPath/create-quotation',
        DataAndFileRequest(data: data.toJson()).toJson(),
      );

      return BaseResponse.fromJson(response);
    } catch (err) {
      rethrow;
    }
  }
}
