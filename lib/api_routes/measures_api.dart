import 'dart:io';
import 'package:api/client/cococare_client.dart';
import 'package:flutter/foundation.dart';

class MeasuresApi {

  static Future<List<Map<String, dynamic>>> getHealthDataPoints( String patientId, { DateTime? fromDate, DateTime? toDate }) async {
    final client = CococareApiClient.instance;
    final endpoint = Uri.parse('${client.baseUrl}/measures/patient/$patientId');
    
    try {
      final queryParams = <String, String>{};
      if (fromDate != null) {
        queryParams['from_date'] = fromDate.toUtc().toIso8601String();
      }
      if (toDate != null) {
        queryParams['to_date'] = toDate.toUtc().toIso8601String();
      }

      final response = await client.dio.getUri(
        endpoint.replace(queryParameters: queryParams),
      );
      
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
  
  static Future<Map<String, dynamic>> sendMeasures( String patientId, List<Map<String, dynamic>> measures ) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.postUri(
        Uri.parse('${client.baseUrl}/measures/patient/$patientId'),
        data: measures,
      );
      
      final data = response.data;
      if (response.statusCode != HttpStatus.ok) {
        throw ApiRequestFailure(
          body: data,
          statusCode: response.statusCode,
          message: 'Error: ${response.data.toString()}',
        );
      }
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  /// Removes a single healthdatapoint
  /// [dataPointId] - the ID of the data point to remove
  static Future<void> removeHealthDataPoint( String dataPointId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/measures/$dataPointId');
      
      final response = await client.dio.deleteUri(endpoint);
      
      if (response.statusCode != HttpStatus.noContent) {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Error removing health data point: ${response.data.toString()}',
        );
      }
    } catch (e) {
      debugPrint('Error in removeHealthDataPoint: $e');
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

  static Future<Map<DateTime, int>> fetchTotalHealthDataPoints(String patientId) async {
    try {
      final client = CococareApiClient.instance;
      final response = await client.dio.getUri(Uri.parse('${client.baseUrl}/measures/patient/$patientId/daily-counts'));
      
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = response.data;
        final Map<DateTime, int> dataList = {};
        
        data.forEach((dateStr, count) {
          final date = DateTime.parse(dateStr);
          dataList[date] = count as int;
        });

        return dataList;
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Error: ${response.data.toString()}',
        );
      }
    } catch (e) {
      debugPrint('Error in fetchTotalHealthDataPoints: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> updateHealthDataPoint(String dataPointId, Map<String, dynamic> healthData) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/measures/$dataPointId');
      
      final response = await client.dio.putUri(
        endpoint,
        data: healthData,
      );
      
      if (response.statusCode != HttpStatus.ok) {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Error updating health data point: ${response.data.toString()}',
        );
      }
      return response.data;
    } catch (e) {
      debugPrint('Error in updateHealthDataPoint: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getHealthDataPointsByType(
    String patientId,
    String dataType, {
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/measures/patient/$patientId/type/$dataType');
      
      final queryParams = <String, dynamic>{};
      if (fromDate != null) {
        queryParams['from_date'] = fromDate.toUtc().toIso8601String();
      }
      if (toDate != null) {
        queryParams['to_date'] = toDate.toUtc().toIso8601String();
      }

      final response = await client.dio.getUri(
        endpoint.replace(queryParameters: queryParams),
      );
      
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> rawData = response.data;
        return rawData.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        throw ApiRequestFailure(
          body: response.data,
          statusCode: response.statusCode,
          message: 'Error: ${response.data.toString()}',
        );
      }
    } catch (e) {
      debugPrint('Error in getHealthDataPointsByType: $e');
      rethrow;
    }
  }
}