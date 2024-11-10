import 'package:api/client/cococare_client.dart';

/// API class for handling study-related HTTP requests
class StudyApi {
  static Future<(List<dynamic>? studies, String error)> getStudies() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/studies');
    
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

  static Future<(Map<String, dynamic>? data, String error)> postStudy(Map<String, dynamic> studyData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/studies');
    
    try {
      final response = await client.dio.postUri(endpoint, data: studyData);
      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> putStudy( int id, Map<String, dynamic> studyData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/studies/$id');
    
    try {
      final response = await client.dio.putUri(endpoint, data: studyData);
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

  static Future<String> deleteStudy(int id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/studies/$id');
    
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
