import 'dart:async';

import 'package:demo_flutter_app/core/domain/network/network_manager.dart';
import 'package:demo_flutter_app/core/models/movie/movie.dart';
import 'package:injectable/injectable.dart';

abstract class MovieRepository {
  FutureOr<List<Movie>> getPopularMovie();
}

@Injectable(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this.networkManager);
  final NetworkManager networkManager;

  @override
  FutureOr<List<Movie>> getPopularMovie() async {
    final response = await networkManager.getPopularMovie();
    return response.data ?? [];
  }
}
