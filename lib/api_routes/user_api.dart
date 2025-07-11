import 'package:api/api.dart';
import 'package:flutter/foundation.dart';

class CococareUserApi {

  // Get patient data from the database id
  static Future<(Map<String, dynamic>? userData, String? error)> getUserData(String databaseId) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/$databaseId');
    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return (data, null);
      } else {
        final errorMessage = 'API request failed with status code: ${response.statusCode}';
        debugPrint('$errorMessage\nResponse data: ${response.data}');
        return (null, errorMessage);
      }
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      return (null, errorMessage);
    }
  }

  // Get doc data from the database id
  static Future<(Map<String, dynamic>? userData, String? error)> getDocData(String databaseId) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/doctors/$databaseId');
    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return (data, null);
      } else {
        final errorMessage = 'API request failed with status code: ${response.statusCode}';
        debugPrint('$errorMessage\nResponse data: ${response.data}');
        return (null, errorMessage);
      }
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      return (null, errorMessage);
    }
  }
}