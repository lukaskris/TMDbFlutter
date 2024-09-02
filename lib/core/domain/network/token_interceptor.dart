import 'package:demo_flutter_app/core/utils/session_storage.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenInterceptor extends Interceptor {
  final SessionStorageService sessionStorageService;

  TokenInterceptor(this.sessionStorageService);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmU2OWJlZTk3MjJjYTZhOGMxMWVjMDNjZDU1NTdhYSIsIm5iZiI6MTcyNTIzNjM0OS42MjE5NDMsInN1YiI6IjVjYzEyNzExMGUwYTI2NTRlOWYzYTZmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l3w2hRA6Y3MbfQsIlFXUR-Ilb05A-GOIWuovPMOZqcQ';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token expiration or unauthorized errors
      // You might want to refresh the token here or redirect to login screen
      // This is just a placeholder for handling 401 errors
      print('Unauthorized! Token might have expired.');
    }

    super.onError(err, handler);
  }
}
