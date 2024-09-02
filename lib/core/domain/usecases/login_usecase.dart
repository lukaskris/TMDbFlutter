import 'dart:async';
import 'dart:ffi';

import 'package:demo_flutter_app/core/domain/base/param_usecase.dart';
import 'package:demo_flutter_app/core/domain/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

class LoginParameter {
  final String username;
  final String password;
  LoginParameter({required this.username, required this.password});
}

@injectable
class LoginUsecase implements ParamUseCase<bool, LoginParameter> {
  final AuthenticationRepository _authenticationRepository;

  LoginUsecase(this._authenticationRepository);

  @override
  FutureOr<bool> execute(LoginParameter params) {
    return _authenticationRepository.authenticate(
        username: params.username, password: params.password);
  }
}
