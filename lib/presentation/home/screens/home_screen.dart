import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_flutter_app/core/domain/network/network_url.dart';
import 'package:demo_flutter_app/injection.dart';
import 'package:demo_flutter_app/presentation/home/bloc/home_bloc.dart';
import 'package:demo_flutter_app/presentation/home/bloc/home_event.dart';
import 'package:demo_flutter_app/presentation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: BlocProvider(
        create: (context) => getIt<HomeBloc>()
          ..add(FetchPopularMovies()), // Trigger the first fetch on load
        child: const HomeContent(),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              // Trigger the fetch event when pulled to refresh
              context.read<HomeBloc>().add(FetchPopularMovies());
            },
            child: ListView.builder(
              itemCount: state.popularMovies.length,
              itemBuilder: (context, index) {
                final banner = state.popularMovies[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl:
                        NetworkUrl.imageUrl + (banner.movie.posterPath ?? ''),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(banner.movie.title ?? ''),
                  subtitle: Text(banner.movie.overview ?? ''),
                );
              },
            ),
          );
        } else if (state is HomeError) {
          return RefreshIndicator(
            onRefresh: () async {
              // Trigger the fetch event on error state as well
              context.read<HomeBloc>().add(FetchPopularMovies());
            },
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(state.error),
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No data available.'));
      },
    );
  }
}
