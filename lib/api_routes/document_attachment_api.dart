import 'dart:io';
import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// API client for managing document attachments (upload, list, download, delete).
class DocumentAttachmentApi {
  /// Upload a document or image for a user.
  ///
  /// Returns a tuple `(data, error)` where `data` is the created attachment as
  /// `Map<String, dynamic>` when the request succeeds and `error` is an empty
  /// string. When the request fails `data` is `null` and `error` contains a
  /// description of the failure.
  static Future<(Map<String, dynamic>? data, String error)> uploadDocument(
      {required String userId, required String filePath, required String displayName,}) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/documents/upload/$userId');

      final fileName = filePath.split(Platform.pathSeparator).last;
      final file = await MultipartFile.fromFile(filePath, filename: fileName);

      final formData = FormData.fromMap({
        'file': file,
        'display_name': displayName,
      });

      final response = await client.dio.postUri(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == HttpStatus.created) {
        return (Map<String, dynamic>.from(response.data), '');
      } else {
        debugPrint('uploadDocument failed with status: ${response.statusCode}, body: ${response.data}');
        return (null, 'Failed to upload document. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Upload a document or image for a user using bytes (web-compatible).
  static Future<(Map<String, dynamic>? data, String error)> uploadDocumentFromBytes(
      {required String userId, required Uint8List fileBytes, required String fileName, required String displayName,}) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/documents/upload/$userId');

      final file = MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );

      final formData = FormData.fromMap({
        'file': file,
        'display_name': displayName,
      });

      final response = await client.dio.postUri(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == HttpStatus.created) {
        return (Map<String, dynamic>.from(response.data), '');
      } else {
        debugPrint('uploadDocumentFromBytes failed with status: ${response.statusCode}, body: ${response.data}');
        return (null, 'Failed to upload document. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Get all documents for a specific user.
  static Future<(List<Map<String, dynamic>>? data, String error)> getUserDocuments(String userId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/documents/user/$userId');

      final response = await client.dio.getUri(endpoint);
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> raw = response.data;
        return (raw.cast<Map<String, dynamic>>(), '');
      } else {
        debugPrint('getUserDocuments failed with status: ${response.statusCode}, body: ${response.data}');
        return (null, 'Failed to fetch documents. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  /// Download a document by its ID. Returns the raw bytes.
  static Future<(Uint8List? data, String error)> downloadDocument(int documentId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/documents/download/$documentId');

      final response = await client.dio.getUri(
        endpoint,
        options: Options(
          responseType: ResponseType.bytes,
          validateStatus: (status) {
            // Accept 200, 201, 202, 204, 206, 301, 302, 303, 307, 308
            return status != null && status < 400;
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        return (response.data as Uint8List, '');
      } else {
        debugPrint('downloadDocument failed with status: ${response.statusCode}');
        return (null, 'Failed to download document. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('downloadDocument error: $e');
      return (null, e.toString());
    }
  }

  /// Delete a document by its ID.
  static Future<String> deleteDocument(int documentId) async {
    try {
      final client = CococareApiClient.instance;
      final endpoint = Uri.parse('${client.baseUrl}/documents/$documentId');
      final response = await client.dio.deleteUri(endpoint);

      if (response.statusCode == HttpStatus.noContent) {
        return '';
      } else {
        debugPrint('deleteDocument failed with status: ${response.statusCode}, body: ${response.data}');
        return 'Failed to delete document. Status code: ${response.statusCode}';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
