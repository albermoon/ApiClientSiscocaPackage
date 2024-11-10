import 'package:api/client/cococare_client.dart';

class DoctorApi {
  static Future<(List<dynamic>? doctors, String error)> getDoctors() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/doctors');
    
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

  static Future<(Map<String, dynamic>? data, String error)> postDoctor( Map<String, dynamic> doctorData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/doctors');
    
    try {
      final response = await client.dio.postUri(endpoint, data: doctorData);
      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> putDoctor(
      int id, Map<String, dynamic> doctorData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/doctors/$id');
    
    try {
      final response = await client.dio.putUri(endpoint, data: doctorData);
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

  static Future<String> deleteDoctor(int id) async { final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/doctors/$id');
    
    try {
      final response = await client.dio.deleteUri(endpoint);
      if (response.statusCode == 204) {
        return '';
      } else {
        return response.data.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}