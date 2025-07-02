import 'package:api/client/cococare_client.dart';

class MessagesApi {
  static Future<(Map<String, dynamic>?, String)> postMessageToAll(Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/all');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> postMessageToPatient(String patientId, Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/patient/$patientId');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> postMessageToHospital(String hospitalId, Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/hospital/$hospitalId');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> postMessageToStudy(String studyId, Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/messages/study/$studyId');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>?, '');
    } catch (e) {
      return (null, e.toString());
    }
  }
} 