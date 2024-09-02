// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:demo_flutter_app/core/domain/di/network_module.dart' as _i148;
import 'package:demo_flutter_app/core/domain/network/api_services.dart'
    as _i334;
import 'package:demo_flutter_app/core/domain/network/network_manager.dart'
    as _i883;
import 'package:demo_flutter_app/core/domain/network/token_interceptor.dart'
    as _i67;
import 'package:demo_flutter_app/core/domain/repository/authentication_repository.dart'
    as _i660;
import 'package:demo_flutter_app/core/domain/repository/movie_repository.dart'
    as _i6;
import 'package:demo_flutter_app/core/domain/usecases/login_usecase.dart'
    as _i898;
import 'package:demo_flutter_app/core/utils/session_storage.dart' as _i274;
import 'package:demo_flutter_app/presentation/home/bloc/home_bloc.dart'
    as _i912;
import 'package:demo_flutter_app/presentation/home/domain/usecases/get_popular_movie_use_case.dart'
    as _i602;
import 'package:demo_flutter_app/presentation/login/bloc/login_bloc.dart'
    as _i187;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.factory<_i274.SessionStorageService>(
        () => networkModule.sessionStorageService);
    gh.factory<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i334.AppServices>(() => networkModule.apiService);
    gh.lazySingleton<_i883.NetworkManager>(
        () => _i883.NetworkManager(gh<_i334.AppServices>()));
    gh.factory<_i6.MovieRepository>(
        () => _i6.MovieRepositoryImpl(gh<_i883.NetworkManager>()));
    gh.factory<_i660.AuthenticationRepository>(
        () => _i660.AuthenticationRepositoryImpl(gh<_i883.NetworkManager>()));
    gh.singleton<_i67.TokenInterceptor>(
        () => _i67.TokenInterceptor(gh<_i274.SessionStorageService>()));
    gh.factory<_i602.GetPopularMovieUseCase>(
        () => _i602.GetPopularMovieUseCase(gh<_i6.MovieRepository>()));
    gh.factory<_i912.HomeBloc>(() => _i912.HomeBloc(
        getPopularMovieUseCase: gh<_i602.GetPopularMovieUseCase>()));
    gh.factory<_i898.LoginUsecase>(
        () => _i898.LoginUsecase(gh<_i660.AuthenticationRepository>()));
    gh.factory<_i187.LoginBloc>(
        () => _i187.LoginBloc(gh<_i898.LoginUsecase>()));
    return this;
  }
}

class _$NetworkModule extends _i148.NetworkModule {}
