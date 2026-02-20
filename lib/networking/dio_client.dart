import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://your-base-url.com",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    _dio = Dio(options);
  }

  Future<Response?> requestGET({
    required String path,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (token != null) "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print("GET ERROR: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }

  Future<Response?> requestPOST({
    required String path,
    required dynamic data,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            if (token != null) "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print("POST ERROR: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }
}
