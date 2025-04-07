import 'package:dio/dio.dart';

class DioApiClient {
  final dio = createDio();

  DioApiClient._internal();

  static final _singleton = DioApiClient._internal();

  factory DioApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

    return dio;
  }
}
