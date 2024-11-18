import 'package:api/api.dart';

class MedicalPassportApi {
  static Future<(Map<String, dynamic>? passport, String error)> getMedicalPassport(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.getUri(
        Uri.parse('${client.baseUrl}/medical-passport/patient/$patientId'),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        return (data, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get medical passport'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(bool success, String error)> createMedicalPassport(Map<String, dynamic> passportData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/medical-passport/'),
        data: passportData,
      );
      if (response.statusCode == 201) {
        return (true, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to create medical passport'
        );
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(bool success, String error)> updateMedicalPassport(Map<String, dynamic> passportData) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.putUri(
        Uri.parse('${client.baseUrl}/medical-passport/'),
        data: passportData,
      );
      if (response.statusCode == 200) {
        return (true, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to update medical passport'
        );
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  static Future<(bool success, String error)> deleteMedicalPassport(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.deleteUri(
        Uri.parse('${client.baseUrl}/medical-passport/patient/$patientId'),
      );
      if (response.statusCode == 204) {
        return (true, '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to delete medical passport'
        );
      }
    } catch (e) {
      return (false, e.toString());
    }
  }
}