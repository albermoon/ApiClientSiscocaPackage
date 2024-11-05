import 'package:api/api.dart';

class CococareUserDeviceApi {
  
  static Future<(bool success, String error)> postUserDevice(Map<String, dynamic> deviceData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/user-device/'),
        data: deviceData,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return (true, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to create user device'
        );
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? device, String error)> getUserDevice() async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.getUri(
        Uri.parse('${client.baseUrl}/user-device/'),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get user device'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}