import 'package:api/api.dart';

class NewsCategoriesApi {
  static Future<(List<dynamic>? data, String error)> getCategories() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/categories');
    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> postCategory(Map<String, dynamic> category) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/categories');
    try {
      final response = await client.dio.postUri(endpoint, data: category);
      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> putCategory(int id, Map<String, dynamic> category) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/categories/$id');
    try {
      final response = await client.dio.putUri(endpoint, data: category);
      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<String> deleteCategory(int id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/categories/$id');
    try {
      final response = await client.dio.deleteUri(endpoint);
      if (response.statusCode == 204) {
        return '';
      }
      return response.data.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
