import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_exceptions.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final Dio dio;

  AuthInterceptor(this.secureStorage, this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.read(key: 'jwt_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Здесь можно вызвать событие выхода, но пока просто пробросим ошибку
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ApiException('Unauthorized', statusCode: 401),
      ));
    } else {
      handler.next(err);
    }
  }
}