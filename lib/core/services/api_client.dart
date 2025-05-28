import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:e_ride_up/core/constants/api_urls.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppUrls.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ));

  ApiClient() {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: true,
      maxWidth: 90,
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String path, dynamic data, {bool isFormData = false}) async {
    try {
      final requestData = isFormData ? FormData.fromMap(data) : data;
      return await _dio.post(path, data: requestData);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String path, dynamic data, {bool isFormData = false}) async {
    try {
      final requestData = isFormData ? FormData.fromMap(data) : data;
      return await _dio.put(path, data: requestData);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> patch(String path, dynamic data, {bool isFormData = false}) async {
    try {
      final requestData = isFormData ? FormData.fromMap(data) : data;
      return await _dio.patch(path, data: requestData);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(dynamic error) {
    if (error is DioException) {
      print('Dio Error: ${error.response?.data ?? error.message}');
    } else {
      print('Unexpected Error: $error');
    }
  }
}
