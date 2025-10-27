import 'package:api/api.dart';

class CococareTaskApi {
  /// Get all tasks
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

  /// Get tasks assigned to a specific patient
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

  /// Get pending tasks for a specific patient
  static Future<(List<dynamic>? pendingTasks, String error)> getPendingTasks(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks/pending/$patientId').toString(),
      );
      
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get pending tasks'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? task, String error)> postTask(Map<String, dynamic> taskData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.post(
        Uri.parse('${client.baseUrl}/tasks').toString(),
        data: taskData,
      );
      
      if (response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to create task'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Update an existing task
  static Future<(Map<String, dynamic>? task, String error)> putTask( Map<String, dynamic> taskData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.put(
        Uri.parse('${client.baseUrl}/tasks/').toString(),
        data: taskData,
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to update task'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Delete a task
  static Future<(bool task, String error)> deleteTask(int id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.delete(
        Uri.parse('${client.baseUrl}/tasks/$id').toString(),
      );
      
      if (response.statusCode == 204) {
        return (true, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to delete task'
        );
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(bool task, String error)> desactivateTask(int id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.delete(
        Uri.parse('${client.baseUrl}/tasks/desactivate/$id').toString(),
      );
      if (response.statusCode == 204) {
        return (true, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to delete task'
        );
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  /// Assigned task to a patient
  static Future<(Map<String, dynamic>? assignment, String error)> assignedTask(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.post(
        Uri.parse('${client.baseUrl}/tasks/assigned/$patientId').toString(),
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to assign task'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Get a specific task by ID
  static Future<(Map<String, dynamic>? task, String error)> getTaskById(int id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks/$id').toString(),
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get task'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}