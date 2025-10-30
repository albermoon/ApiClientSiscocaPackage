import 'dart:io';

import 'package:api/api.dart';

class AlertApi {
  static Future<(List<dynamic>?, String)> getAlerts() async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts');
      final response = await client.dio.getUri(endpoint);
      final data = response.data as List<dynamic>?;
      return (data, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> postAlert(Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts');
      final response = await client.dio.postUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> putAlert(Map<String, dynamic> data) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts/');
      final response = await client.dio.putUri(endpoint, data: data);
      return (response.data as Map<String, dynamic>, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<String> deleteAlert(String id) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts/$id');
      await client.dio.deleteUri(endpoint);
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<(List<dynamic>?, String)> getPatientAlerts(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts/patient/$patientId');
      final response = await client.dio.getUri(endpoint);
      final data = response.data as List<dynamic>?;
      return (data, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(Map<String, dynamic>?, String)> markAlertAsRead(String id, String doctorId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts/$id/read');
      final response = await client.dio.putUri(endpoint, data: {'doctor_id': doctorId});
      return (response.data as Map<String, dynamic>, '');
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(int?, String)> getTotalAlerts() async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/alerts/total');
      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> responseData = response.data;
        final int totalAlerts = responseData['total_alerts'] as int;
        return (totalAlerts, '');
      } else {
        return (null, 'Failed to fetch alerts: Status code ${response.statusCode}');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}
