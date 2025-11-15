import 'package:api/client/cococare_client.dart';

class HospitalApi {
  static Future<(List<dynamic>? hospitals, String error)> getHospitals() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/hospitals');

    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>?;
        return (data, '');
      } else {
        return (null, response.data.toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> postHospital(Map<String, dynamic> hospitalData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/hospital');

    try {
      final response = await client.dio.postUri(endpoint, data: hospitalData);
      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> putHospital(int id, Map<String, dynamic> hospitalData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/hospital/$id');

    try {
      final response = await client.dio.putUri(endpoint, data: hospitalData);
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        return (null, response.data.toString());
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(bool?, String)> deleteHospital(int id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/hospital/$id');

    try {
      final response = await client.dio.deleteUri(endpoint);
      if (response.statusCode == 204) {
        return (true, '');
      }
      return (true, '');
    } catch (e) {
      return (null, e.toString());
    }
  }
}
