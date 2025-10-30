import 'package:api/api.dart';

class AlertThresholdApi {
  static Future<(List<dynamic>?, String)> getAlertThresholds() async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alert-thresholds');
      final response = await client.dio.getUri(endpoint);
      return (response.data as List<dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> postAlertThreshold(Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alert-thresholds');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> putAlertThreshold(int id, Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alert-thresholds/$id');
      final response = await client.dio.putUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<String> deleteAlertThreshold(int id) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alert-thresholds/$id');
      await client.dio.deleteUri(endpoint);
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<(List<dynamic>?, String)> getThresholdsByPatient(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alert-thresholds/patient/$patientId');
      final response = await client.dio.getUri(endpoint);
      return (response.data as List<dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }
}
