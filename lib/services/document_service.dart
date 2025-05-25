import 'package:accounting_module/core/http/http_client.dart';

class DocumentService {
  static final HttpClient _http = HttpClient();
  static final String _baseApiPath = '/api/document/v1';

  static Future<String> generateDocumentCode(int documentType) async {
    try {
      final Map<String, dynamic> response = await _http.get(
        '$_baseApiPath/generate-document-code/$documentType',
      );
      return response['data'] as String;
    } catch (_) {
      rethrow;
    }
  }
}
