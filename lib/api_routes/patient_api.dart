import 'package:api/api.dart';
import 'package:flutter/foundation.dart';

class CococarePatientApi {
  /// Get all patients
  static Future<(List<Map<String, dynamic>>? data, String error)> getPatients() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients');

    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data as List<dynamic>;
        return (responseData.cast<Map<String, dynamic>>(), '');
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

  /// Get patient by ID
  static Future<(Map<String, dynamic>? data, String error)> getPatientById(String id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/$id');

    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>, '');
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

  static Future<(List<Map<String, dynamic>>? data, String error)> getPatientsByStudyId(String id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/study/$id');

    try {
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data as List<dynamic>;
        return (responseData.cast<Map<String, dynamic>>(), '');
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

  /// Create new patient
  static Future<(Map<String, dynamic>? data, String error)> postPatient(Map<String, dynamic> patientData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients');

    try {
      final response = await client.dio.postUri(endpoint, data: patientData);
      if (response.statusCode == 201) {
        return (response.data as Map<String, dynamic>, '');
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

  /// Update existing patient
  static Future<(Map<String, dynamic>? data, String error)> putPatient(Map<String, dynamic> patientData) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/');

    try {
      final response = await client.dio.putUri(endpoint, data: patientData);
      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>, '');
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

  static Future<(bool data, String error)> deletePatient(String id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/$id');

    try {
      final response = await client.dio.deleteUri(endpoint);
      if (response.statusCode == 204) {
        return (true, '');
      } else {
        final errorMessage = 'API request failed with status code: ${response.statusCode}';
        debugPrint('$errorMessage\nResponse data: ${response.data}');
        return (false, response.data.toString());
      }
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      return (false, errorMessage);
    }
  }

  /// Delete patient
  static Future<String> deleteMedicalPassportPatient(String id) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/$id');

    try {
      final response = await client.dio.deleteUri(endpoint);
      if (response.statusCode == 204) {
        return '';
      } else {
        final errorMessage = 'API request failed with status code: ${response.statusCode}';
        debugPrint('$errorMessage\nResponse data: ${response.data}');
        return errorMessage;
      }
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      return errorMessage;
    }
  }

  /// Update device token
  static Future<String> updateDeviceToken(String patientId, String deviceToken) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/patients/$patientId/device-token');

    try {
      final response = await client.dio.putUri(
        endpoint,
        data: {'device_token': deviceToken},
      );

      if (response.statusCode == 200) {
        return '';
      } else {
        final errorMessage = 'API request failed with status code: ${response.statusCode}';
        debugPrint('$errorMessage\nResponse data: ${response.data}');
        return errorMessage;
      }
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: ${e.toString()}';
      return errorMessage;
    }
  }
}
