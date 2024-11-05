
import 'package:api/token/token_refresher.dart';
import 'package:api/token/token_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTokenRefresher extends TokenRefresher {

  @override
  Future<String?> refreshToken(TokenStorage tokenProvider) async {
    final token = (await FirebaseAuth.instance.currentUser?.getIdTokenResult(true))?.token;
    await tokenProvider.saveToken(token!);
    return token;
  }
}