import 'package:api/token/token_storage.dart';

abstract class TokenRefresher {
  Future<String?> refreshToken(TokenStorage tokenProvider) => throw UnimplementedError();
}
