import 'package:demo_flutter_app/core/domain/network/network_url.dart';
import 'package:demo_flutter_app/core/models/apiresponse/api_response.dart';
import 'package:demo_flutter_app/core/models/movie/movie.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: NetworkUrl.baseUrl)
abstract class AppServices {
  factory AppServices(Dio dio) = _AppServices;

  @GET(NetworkUrl.popular)
  Future<ApiResponse<List<Movie>>> getPopularMovie();
}
