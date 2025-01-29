import 'dart:io';
import 'package:api/client/cococare_client.dart';
import 'package:flutter/foundation.dart';

class MeasuresApi {

  static Future<List<Map<String, dynamic>>> getHealthDataPoints(String patientId) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/measures/patient/$patientId');
    
    try {
      final response = await client.dio.getUri(endpoint);
      
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> rawData = response.data;
        return rawData.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Error: ${response.data.toString()} ',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
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
          message: 'Error: ${response.data.toString()}',
        );
      }
    }
    catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getTotalWeekMeasures() async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/measures/total_week');
    
    try {
      final response = await client.dio.getUri(endpoint);
      
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> rawData = response.data;
        return rawData.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Error: ${response.data.toString()} ',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}