import 'dart:convert';
import 'package:api/api.dart';

/// API client class for survey-specific task operations
class CococareSurveyApi {
  /// Get all survey tasks
  static Future<(List<dynamic>? surveys, String error)> getSurveys() async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks/survey').toString(),
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to get surveys');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Get a specific survey by ID
  static Future<(Map<String, dynamic>? survey, String error)> getSurveyById(int id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks/survey/$id').toString(),
      );

      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>?, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to get survey');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Create a new survey
  static Future<(Map<String, dynamic>? survey, String error)> createSurvey(Map<String, dynamic> surveyData) async {
    try {
      logJsonInChunks(surveyData);
      final client = CococareApiClient.instance;
      final response = await client.dio.post(
        Uri.parse('${client.baseUrl}/tasks/survey').toString(),
        data: surveyData,
      );

      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>?, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to create survey');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Update an existing survey
  static Future<(Map<String, dynamic>? survey, String error)> updateSurvey(int id, Map<String, dynamic> surveyData) async {
    try {
      // logJsonInChunks(surveyData);
      final client = CococareApiClient.instance;
      final response = await client.dio.put(
        Uri.parse('${client.baseUrl}/tasks/survey/$id').toString(),
        data: surveyData,
      );

      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>?, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to update survey');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Delete a survey
  static Future<String> deleteSurvey(int id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.delete(
        Uri.parse('${client.baseUrl}/tasks/survey/$id').toString(),
      );

      if (response.statusCode == 204) {
        return '';
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to delete survey');
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Get surveys assigned to a specific patient
  static Future<(List<dynamic>? surveys, String error)> getAssignedSurveys(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/tasks/survey/patient/$patientId').toString(),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>?, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to get assigned surveys');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}

/// Utility function to log large JSON objects in chunks
void logJsonInChunks(Map<String, dynamic> json, {int chunkSize = 1000}) {
  final jsonString = JsonEncoder.withIndent(' ').convert(json);
  for (var i = 0; i < jsonString.length; i += chunkSize) {
    print(jsonString.substring(i, (i + chunkSize).clamp(0, jsonString.length)));
  }
}
