import 'package:demo_flutter_app/presentation/home/model/banner_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BannerModel> popularMovies;

  HomeLoaded({required this.popularMovies});

  @override
  List<Object?> get props => [popularMovies];
}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});

  @override
  List<Object?> get props => [error];
}
