import 'package:demo_flutter_app/core/domain/network/api_services.dart';
import 'package:demo_flutter_app/core/models/apiresponse/api_response.dart';
import 'package:demo_flutter_app/core/models/movie/movie.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkManager {
  final AppServices _appServices;

  NetworkManager(this._appServices);

  Future<bool> authenticate(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'user' && password == 'password') {
      return true;
    } else {
      throw Exception('Invalid username/password');
    }
  }

  Future<ApiResponse<List<Movie>>> getPopularMovie() async {
    final response = await _appServices.getPopularMovie();
    try {
      return response;
    } on DioException catch (e) {
      final message = _handleDioError(e);
      throw Exception(message);
    }
  }

  String _handleDioError(DioException error) {
    String errorMessage;
    if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage =
          'Connection timeout. Please check your internet connection.';
    } else if (error.type == DioExceptionType.sendTimeout) {
      errorMessage = 'Request timeout. Please try again later.';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Response timeout. Server might be down.';
    } else if (error.type == DioExceptionType.badResponse) {
      errorMessage =
          'Received invalid status code: ${error.response?.statusCode}';
    } else if (error.type == DioExceptionType.cancel) {
      errorMessage = 'Request was cancelled. Please try again.';
    } else {
      errorMessage = 'Unexpected error occurred: ${error.message}';
    }

    return errorMessage;
  }
}
