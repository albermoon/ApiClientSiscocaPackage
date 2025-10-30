import 'package:api/token/token_refresher.dart';
import 'package:api/token/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class InterceptorApi extends Interceptor {
  InterceptorApi({
    required this.dio,
    required this.tokenProvider,
    required this.tokenRefresher,
  });
  final Dio dio;
  final TokenStorage tokenProvider;
  final TokenRefresher tokenRefresher;

  static const int maxAttempts = 1;
  static const Duration timeoutDuration = Duration(seconds: 30);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('Making request to: ${options.baseUrl}${options.path}  Port: ${options.uri.port}');
    final token = await tokenProvider.readToken();
    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    options.headers.addAll(headers);
    options.followRedirects = true;
    options.validateStatus = (status) => status != null && status >= 200 && status < 400;

    options.connectTimeout = timeoutDuration;
    options.receiveTimeout = timeoutDuration;
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    int attempts = err.requestOptions.extra['attempts'] as int? ?? 0;
    debugPrint('Request error: ${err.message} (Attempt: $attempts)');

    if (err.response?.statusCode == 401 && attempts < maxAttempts) {
      attempts++;
      err.requestOptions.extra['attempts'] = attempts;

      refreshToken();
      try {
        handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        return onError(e..requestOptions.extra['attempts'] = attempts, handler);
      }
    }

    // Pass the error to the next handler if conditions are not met
    handler.next(err);
  }

  void refreshToken() async {
    await tokenRefresher.refreshToken(tokenProvider);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        'Authorization': 'Bearer ${await tokenProvider.readToken()}',
      },
      extra: requestOptions.extra, // Preserve `extra` field
    );

    // Retry the request with the new options
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
