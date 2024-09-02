import 'dart:async';

import 'package:demo_flutter_app/core/domain/network/network_manager.dart';
import 'package:injectable/injectable.dart';

abstract class AuthenticationRepository {
  FutureOr<bool> authenticate(
      {required String username, required String password});
}

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this.networkManager);
  final NetworkManager networkManager;
  @override
  FutureOr<bool> authenticate(
      {required String username, required String password}) {
    return networkManager.authenticate(username: username, password: password);
  }
}
