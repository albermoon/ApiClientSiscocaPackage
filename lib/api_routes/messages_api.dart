import 'package:api/client/cococare_client.dart';

class MessagesApi {
  static Future<(Map<String, dynamic>?, String)> postMessage(Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(List<dynamic>?, String)> getSentMessages() async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/');
      final response = await client.dio.getUri(endpoint);
      return (response.data as List<dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Get messages that correspond to a specific patient according to backend scope rules.
  /// [patientId] Path parameter.
  /// [limit] Optional query param to limit number of messages (default 10).
  static Future<(List<dynamic>?, String)> getMessagesForPatient(String patientId, {int limit = 10}) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/patient/$patientId?limit=$limit');
      final response = await client.dio.getUri(endpoint);
      return (response.data as List<dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Hard delete a message by id (and its targets via backend cascade).
  /// Returns an empty string on success, error message otherwise.
  /// On failure, the returned message includes the HTTP status code and the
  /// backend ``detail`` field when present, to ease diagnosis from the UI.
  static Future<String> deleteMessage(int id) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/$id');
      final response = await client.dio.deleteUri(endpoint);
      if (response.statusCode == 204 || response.statusCode == 200) {
        return '';
      }
      final data = response.data;
      String detail;
      if (data is Map && data['detail'] != null) {
        detail = data['detail'].toString();
      } else {
        detail = data?.toString() ?? '';
      }
      return 'HTTP ${response.statusCode}${detail.isNotEmpty ? ' - $detail' : ''}';
    } catch (e) {
      return e.toString();
    }
  }
}
