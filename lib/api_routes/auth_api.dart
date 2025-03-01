import 'package:api/api.dart';
import 'package:dio/dio.dart';

class CococareAuthApi {
  static Future<(String? userId, String? error)> login() async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/login')
      );

      final data = response.data as Map<String, dynamic>;
      final userId = data['user_db_id'] as String?;
      
      if (userId != null && userId.isNotEmpty) {
        return (userId, null);
      }
      
      throw ApiRequestFailure(
        statusCode: response.statusCode,
        body: data,
        message: 'User ID not found in response'
      );

    } on DioException catch (e) {
      throw ApiRequestFailure(
        statusCode: e.response?.statusCode ?? 500,
        body: e.response?.data as Map<String, dynamic>?,
        message: e.message ?? 'Network error occurred'
      );
    } catch (e) {
      throw ApiRequestFailure(
        statusCode: 500,
        body: null,
        message: 'Unexpected error: ${e.toString()}'
      );
    }
  }

  static Future<(String? userId, String? error)> loginDoc() async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/doctors/login')
      );

      final data = response.data as Map<String, dynamic>;
      final userId = data['user_db_id'] as String?;
      
      if (userId != null && userId.isNotEmpty) {
        return (userId, null);
      }
      
      throw ApiRequestFailure(
        statusCode: response.statusCode,
        body: data,
        message: 'User ID not found in response'
      );

    } on DioException catch (e) {
      throw ApiRequestFailure(
        statusCode: e.response?.statusCode ?? 500,
        body: e.response?.data as Map<String, dynamic>?,
        message: e.message ?? 'Network error occurred'
      );
    } on ApiRequestFailure {
      rethrow;
    } catch (e) {
      throw ApiRequestFailure(
        statusCode: 500,
        body: null,
        message: 'Unexpected error: ${e.toString()}'
      );
    }
  }
}