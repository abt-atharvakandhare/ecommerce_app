import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'interceptor/jwt_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/api_constants.dart';

class DioClient{
  late final Dio dio;
  late final PersistCookieJar cookieJar;

  DioClient(){
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          ApiConstants.packageNameHeader: ApiConstants.packageNameValue,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(
      storage: FileStorage('${appDocDir.path}/.cookies/'),
    );

    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(JwtInterceptor(dio: dio));
  }
}
