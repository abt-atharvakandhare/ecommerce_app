import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import '../../storage/token_storage.dart';

class JwtInterceptor extends QueuedInterceptor {
  final Dio dio;

  JwtInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
     options.headers[ApiConstants.packageNameHeader] = ApiConstants.packageNameValue;

     final token = await TokenStorage.getAccessToken();
     if (token != null && token.isNotEmpty){
       options.headers['Authorization'] = 'Bearer $token';
     }
     return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains(ApiConstants.refreshToken)){

      try{
        final response = await dio.post(ApiConstants.refreshToken);

        if (response.statusCode == 200){
          final newToken = response.data['data']?['access_token'] ?? response.data['access_token'];

          if (newToken != null){
            await TokenStorage.saveAccessToken(newToken.toString());

            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';

            final retryResponse = await dio.fetch(options);
            return handler.resolve(retryResponse);
          }
        }
      }catch(refreshError){
        await TokenStorage.clearToken();
      }
    }

    return handler.next(err);
  }
}
