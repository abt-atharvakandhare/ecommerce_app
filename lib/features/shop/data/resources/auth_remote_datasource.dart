import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/storage/token_storage.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource({required this.dio});
  Future<Response> login({required String email, required String password}) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    final accessToken = response.data['data']?['access_token'] ??
        response.data['access_token'];

    if (accessToken != null) {
      await TokenStorage.saveAccessToken(accessToken.toString());
    }

    return response;
  }

  Future<Response> refreshToken() async {
    final response = await dio.post(ApiConstants.refreshToken);

    final newAccessToken = response.data['data']?['access_token'] ??
        response.data['access_token'];

    if (newAccessToken != null) {
      await TokenStorage.saveAccessToken(newAccessToken.toString());
    }

    return response;
  }

  Future<Response> logout() async {
    final response = await dio.post(ApiConstants.logout);
    await TokenStorage.clearToken();
    return response;
  }
}