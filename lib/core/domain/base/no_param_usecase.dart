// ignore_for_file: one_member_abstracts
import 'dart:async';

/// Base class for use case without parameter

abstract class NoParamUseCase<Type> {
  /// execute usecase
  FutureOr<Type> execute();
}
