import 'package:api/client/cococare_client.dart';

class NewsApi {

  static Future<(List<dynamic>? userData, String error)> getNews() async {
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

  static Future<(List<dynamic>? userData, String error)> getCategories() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/news/categories');
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

}