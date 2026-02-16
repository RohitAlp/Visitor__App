import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late Dio _dio;

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://your-base-url.com/api/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response?> getRequest({
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
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

  Future<Response?> postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
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
