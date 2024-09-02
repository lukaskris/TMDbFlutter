import 'package:demo_flutter_app/core/domain/base/delegate_item.dart';
import 'package:demo_flutter_app/core/models/movie/movie.dart';

class BannerModel extends DelegateItem {
  final Movie movie;

  BannerModel({required this.movie});

  @override
  List<Object?> get props => [movie.id];
}
