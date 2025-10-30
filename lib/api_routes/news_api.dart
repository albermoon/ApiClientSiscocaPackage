import 'package:api/client/cococare_client.dart';

class NewsApi {
  static Future<(List<dynamic>? news, String error)> getNews() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/articles');
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

  static Future<(Map<String, dynamic>? data, String error)> postArticle(Map<String, dynamic> articleData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/articles');
    try {
      final response = await client.dio.postUri(endpoint, data: articleData);
      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>?, '');
      }
      return (null, response.data.toString());
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? data, String error)> putArticle(int id, Map<String, dynamic> articleData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/articles/$id');
    try {
      final response = await client.dio.putUri(endpoint, data: articleData);

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

  static Future<String> deleteArticle(int id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/articles/$id');

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
