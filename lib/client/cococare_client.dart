import 'dart:io';
import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class ApiRequestFailure implements Exception {
  const ApiRequestFailure({
    required this.statusCode,
    required this.body,
    required this.message,
  });

  final int? statusCode;
  final Map<String, dynamic>? body;
  final String? message;
}

enum ApiEnvironment { localhost, localweb, dev, pro }

class CococareApiClient {
  static CococareApiClient? _instance;
  late String baseUrl;
  late Dio dio;
  late TokenStorage tokenProvider;
  late TokenRefresher tokenRefresher;

  CococareApiClient._({
    required this.baseUrl,
    required this.tokenProvider,
    Dio? dioClient,
    required Map<String, String> headers,
  }) {
    dio = dioClient ??
        Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: headers,
            validateStatus: (status) => status != null && status < 500,
          ),
        );

    // Configure the HTTP client to accept self-signed certificates on localhost
    if (!kIsWeb && baseUrl.contains('localhost')) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => host == 'localhost'; // Only accept self-signed certificates for localhost
        return client;
      };
    }

    tokenRefresher = FirebaseTokenRefresher();
    dio.interceptors.add(
      InterceptorApi(
        dio: dio,
        tokenProvider: tokenProvider,
        tokenRefresher: tokenRefresher,
      ),
    );
  }

  static void initialize({
    required ApiEnvironment environment,
    required TokenStorage tokenProvider,
    Dio? dio,
  }) {
    String baseUrl;
    switch (environment) {
      case ApiEnvironment.pro:
        baseUrl = 'https://hos.cocoapp.es:';
        break;
      case ApiEnvironment.dev:
        baseUrl = 'https://devh12.cocoapp.es';
        break;
      case ApiEnvironment.localhost:
        baseUrl = 'http://127.0.0.1:5000';
        break;
      case ApiEnvironment.localweb:
        baseUrl = 'http://localhost:5000';
        break;
    }

    _instance = CococareApiClient._(
      baseUrl: baseUrl,
      tokenProvider: tokenProvider,
      dioClient: dio,
      headers: {
        'Accept': '*/*',
      },
    );
  }

  static CococareApiClient get instance {
    if (_instance == null) {
      throw StateError('CococareApiClient must be initialized before use.');
    }
    return _instance!;
  }
}
