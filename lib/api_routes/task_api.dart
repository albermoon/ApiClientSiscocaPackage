import 'package:api/api.dart';

class CococareTaskApi {
  static Future<(List<dynamic>? tasks, String error)> getTasks() async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get tasks'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(List<dynamic>? assignedTasks, String error)> getAssignedTasks(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks/assigned/$patientId').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get assigned tasks'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}