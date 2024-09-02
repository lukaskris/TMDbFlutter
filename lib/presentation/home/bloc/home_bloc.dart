import 'package:demo_flutter_app/presentation/home/domain/usecases/get_popular_movie_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPopularMovieUseCase getPopularMovieUseCase;

  HomeBloc({required this.getPopularMovieUseCase}) : super(HomeInitial()) {
    on<FetchPopularMovies>(_onFetchPopularMovies);
  }

  Future<void> _onFetchPopularMovies(
      FetchPopularMovies event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      final response = await getPopularMovieUseCase.execute();

      emit(HomeLoaded(popularMovies: response));
    } catch (e) {
      emit(HomeError(error: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
