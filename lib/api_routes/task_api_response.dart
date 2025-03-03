import 'dart:convert';

import 'package:api/api.dart';

class CococareTaskResponseApi {
  static Future<(dynamic tasks, String error)> saveTaskResponse(Map<String, dynamic> taskResponse) async{
    try {
      logJsonInChunks(taskResponse);
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/task_response/'),
        data: taskResponse,
      );
      if (response.statusCode == 201) {
        return (response.data , 'Ok');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to send task response'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(List<dynamic>? task, String error)> getTaskResponseByPatient(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.getUri(
        Uri.parse('${client.baseUrl}/task_response/patient/$patientId'),
      );
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>?,  '');
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get task response'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  static Future<(List<dynamic>? task, String error)> getTaskSurveyResponseByPatient(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      int? parsedId = int.parse(patientId);
      final response = await client.dio.get(
        Uri.parse('${client.baseUrl}/task_response/patient/survey/$parsedId').toString(),
      );
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>?,  '');
      }else if(response.statusCode == 404) {
        return throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Dont exist patient with this id'
        );
      }
       else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Failed to get task response'
        );
      }
    } catch (e) {
      return (null, e.toString());
    }
  }
}


void logJsonInChunks(Map<String, dynamic> json, {int chunkSize = 1000}) {
  final jsonString = JsonEncoder.withIndent('  ').convert(json);
  for (var i = 0; i < jsonString.length; i += chunkSize) {
    print(jsonString.substring(i, (i + chunkSize).clamp(0, jsonString.length)));
  }
}