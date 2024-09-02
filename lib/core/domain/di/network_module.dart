import 'package:demo_flutter_app/core/domain/network/api_services.dart';
import 'package:demo_flutter_app/core/domain/network/token_interceptor.dart';
import 'package:demo_flutter_app/core/utils/session_storage.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  SessionStorageService get sessionStorageService => SessionStorageService();
  Dio get dio => Dio()
    ..interceptors.add(TokenInterceptor(sessionStorageService))
    ..interceptors.add(PrettyDioLogger(requestHeader: true));

  AppServices get apiService => AppServices(dio);
}
