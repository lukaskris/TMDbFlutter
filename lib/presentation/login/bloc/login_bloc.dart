import 'package:demo_flutter_app/core/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUsecase;

  LoginBloc(this._loginUsecase) : super(LoginInitial()) {
    on<LoginEvent>(
      _mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void _mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginButtonPressed) {
      emit(LoginLoading());
      try {
        final result = await _loginUsecase.execute(
            LoginParameter(username: event.username, password: event.password));
        if (result) {
          emit(LoginSuccess());
        } else {
          emit(const LoginFailure(error: 'Unknown Error'));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    }
  }
}
