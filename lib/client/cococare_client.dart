
import 'package:api/api.dart';
import 'package:dio/dio.dart';

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

enum ApiEnvironment {
  localhost,
  dev,
  pro
}

class CococareApiClient {
  static CococareApiClient? _instance;
  late String baseUrl;
  late TokenStorage tokenProvider;
  late Dio dio;
  late TokenRefresher tokenRefresher;

  CococareApiClient._({
    required this.baseUrl,
    required this.tokenProvider,
    Dio? dioClient,
  }) {
    dio = dioClient ?? Dio();
    tokenRefresher = FirebaseTokenRefresher();
    dio.interceptors.add(InterceptorApi(
      dio: dio,
      tokenProvider: tokenProvider,
      tokenRefresher: tokenRefresher,
    ));
  }

  static void initialize({
    required ApiEnvironment environment,
    required TokenStorage tokenProvider,
    Dio? dio,
  }) {
    String baseUrl;
    switch (environment) {
      case ApiEnvironment.pro:
        baseUrl = 'https://backend.cocoapp.es';
        break;
      case ApiEnvironment.dev:
        baseUrl = 'http://54.36.98.31:5000';
        break;
      case ApiEnvironment.localhost:
        baseUrl = 'http://192.168.1.191:5000';
        break;
      default:
        throw ArgumentError('Invalid environment');
    }

    _instance = CococareApiClient._(
      baseUrl: baseUrl,
      tokenProvider: tokenProvider,
      dioClient: dio,
    );
  }

  static CococareApiClient get instance {
    if (_instance == null) {
      throw StateError('CococareApiClient must be initialized before use.');
    }
    return _instance!;
  }
}