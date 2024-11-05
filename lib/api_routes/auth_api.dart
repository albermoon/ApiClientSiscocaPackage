import 'package:api/api.dart';

class CococareAuthApi {
  static Future<(String? userId, String? error)> login() async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/login'));
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final userId = data['user_db_id'] as String?;
        if (userId != null && userId.isNotEmpty) {
          return (userId, null);
        } else {
          return (null, 'User ID not found in response');
        }
      } else {
        return (null, 'API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiRequestFailure) {
        return (null, e.message);
      }
      return (null, 'An unexpected error occurred: ${e.toString()}');
    }
  }
}