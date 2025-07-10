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
      final endpoint = Uri.parse('${client.baseUrl}/messages');
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
} 