import 'package:api/api.dart';

class CococareMedicationApi {
  static Future<(List<dynamic>? medications, String error)> getMedicationsPatient(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.getUri(
        Uri.parse('${client.baseUrl}/medications/patient/$patientId'),
      );
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to get medications');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>? medication, String error)> getMedicationById(String id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/medications/$id').toString(),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to get medication');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(bool success, String error)> addMedication(Map<String, dynamic> medicationData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.post(
        Uri.parse('${client.baseUrl}/medications').toString(),
        data: medicationData,
      );
      if (response.statusCode == 201) {
        return (true, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to add medication');
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(bool success, String error)> updateMedication(String id, Map<String, dynamic> medicationData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.put(
        Uri.parse('${client.baseUrl}/medications/$id').toString(),
        data: medicationData,
      );
      if (response.statusCode == 200) {
        return (true, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to update medication');
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(bool success, String error)> deleteMedication(String id) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.delete(
        Uri.parse('${client.baseUrl}/medications/$id').toString(),
      );
      if (response.statusCode == 204) {
        return (true, '');
      } else {
        throw ApiRequestFailure(body: response.data, statusCode: response.statusCode, message: 'Failed to delete medication');
      }
    } catch (e) {
      return (false, e.toString());
    }
  }
}
