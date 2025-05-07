import 'package:api/api.dart';

/// {@template version_api}
/// API client for version related endpoints
/// {@endtemplate}
class VersionApi {
  /// Fetches the version information from the server
  /// Returns a tuple with the version data and an error message if any
  static Future<(Map<String, dynamic>?, String)> getVersion() async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/version');
      final response = await client.dio.getUri(endpoint);
      final data = response.data as Map<String, dynamic>?;
      return (data, '');
    } catch (e) {
      return (null, e.toString());
    }
  }
} 