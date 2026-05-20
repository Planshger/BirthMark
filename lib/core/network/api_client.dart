import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'auth_interceptor.dart';

@singleton
class ApiClient {
  late final Dio dio;

  ApiClient(@Named('baseUrl') String baseUrl, FlutterSecureStorage secureStorage, Dio dioInstance)
      : dio = dioInstance {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(AuthInterceptor(secureStorage, dio));
  }
}