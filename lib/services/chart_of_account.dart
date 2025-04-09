import 'package:accounting_module/core/http/http_client.dart';
import 'package:accounting_module/models/responses/chart_of_account.dart';

class ChartOfAccountService {
  static final HttpClient _http = HttpClient();

  static Future<List<ChartOfAccountResponseData>> getData() async =>
      _getData({});

  static Future<List<ChartOfAccountResponseData>> getDataWithSearch(
    String searchKeyword,
  ) async => _getData({'searchKeyword': searchKeyword});

  static Future<List<ChartOfAccountResponseData>> _getData(
    Map<String, dynamic> data,
  ) async {
    try {
      final Map<String, dynamic> response = await _http.post(
        '/api/chart-of-account/v1/get-data',
        data,
      );

      if (response['success'] == true) {
        return (response['data'] as List<dynamic>)
            .map((item) => ChartOfAccountResponseData.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> create(Map<String, dynamic> json) async {
    await _http.post('/api/chart-of-account/v1/create', json);
  }
}
