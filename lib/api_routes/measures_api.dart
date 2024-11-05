import 'dart:io';

import 'package:api/client/cococare_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MeasuresApi {

  static Future<List<Map<String, dynamic>>> getHealthDataPoints(String patientId) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/getMeasures/$patientId');
    try{
      final response = await client.dio.getUri(endpoint);
      final data = response.data;
      if (response.statusCode != HttpStatus.ok){
        throw ApiRequestFailure(
          body: data,
          statusCode: response.statusCode,
          message: 'Unexpected response format: Data is not a Map',
        );
      }
      return data;
    } on DioException catch (e) {
      throw ApiRequestFailure(
        body: e.response?.data,
        statusCode: e.response?.statusCode,
        message: e.message,
      );
    }
  }

  static Future<void> sendMeasures( String patientId, List<Map<String, dynamic>> measures) async {
    try{
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/measures/patient/$patientId'),
        data: measures,
      );
      final data = response.data;
      if (response.statusCode != HttpStatus.ok){
        throw ApiRequestFailure(
          body: data,
          statusCode: response.statusCode,
          message: 'Unexpected response format: Data is not a Map',
        );
      }
    } 
    catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }
}