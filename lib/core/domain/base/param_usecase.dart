import 'dart:async';

/// Base class usecase with parameter
abstract class ParamUseCase<Type, Params> {
  /// @Params handle type of dynamic params
  FutureOr<Type> execute(Params params);
}
