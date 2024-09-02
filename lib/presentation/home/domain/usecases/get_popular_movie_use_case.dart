import 'dart:async';

import 'package:demo_flutter_app/core/domain/base/no_param_usecase.dart';
import 'package:demo_flutter_app/core/domain/repository/movie_repository.dart';
import 'package:demo_flutter_app/presentation/home/model/banner_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPopularMovieUseCase extends NoParamUseCase<List<BannerModel>> {
  final MovieRepository _movieRepository;
  GetPopularMovieUseCase(this._movieRepository);

  @override
  FutureOr<List<BannerModel>> execute() async {
    final response = await _movieRepository.getPopularMovie();
    return response.map((movie) => BannerModel(movie: movie)).toList();
  }
}
