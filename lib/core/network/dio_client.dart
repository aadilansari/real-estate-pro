import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';
import '../errors/failures.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (o) => debugPrint(o.toString()),
        ),
      );
    }

    _dio.interceptors.add(_ErrorInterceptor());
  }

  Dio get dio => _dio;
}

/// Maps Dio errors to typed [Failure] objects.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Failure failure;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        failure = const NetworkFailure('Connection timed out.');
      case DioExceptionType.connectionError:
        failure = const NetworkFailure();
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message =
            err.response?.data?['message'] as String? ??
            'Server error ($statusCode).';
        failure = ServerFailure(message, statusCode: statusCode);
      default:
        failure = const UnknownFailure();
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: failure,
        message: failure.message,
      ),
    );
  }
}
