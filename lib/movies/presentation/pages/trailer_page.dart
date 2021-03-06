// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../movie/domain/i_movie_repository.dart';
import '../../controllers/trailer_controller.dart';
import '../components/home_app_bar.dart';

class TrailerPage extends StatelessWidget {
  const TrailerPage(this.movieId, {Key? key}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(
      TrailerController(
        GetIt.I.get<IMovieRepository>(),
        movieId,
      ),
      tag: movieId.toString(),
    );

    return Obx(
      () {
        if (_controller.trailerUrl != null) {
          return _controller.obx(
            (state) => TrailerPlayer(_controller.trailerUrl!),
            onLoading:
                const Center(child: CircularProgressIndicator.adaptive()),
            onError: (error) => Text(error.toString()),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class TrailerPlayer extends StatelessWidget {
  const TrailerPlayer(this.trailerUrl, {Key? key}) : super(key: key);
  final String trailerUrl;

  @override
  Widget build(BuildContext context) {
    final _controller = YoutubePlayerController(
      initialVideoId: trailerUrl,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    return Scaffold(
      appBar: HomeAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
            _controller.dispose();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Trailer'),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        bottomActions: [
          PlayPauseButton(),
          // FullScreenButton(),
          // RemainingDuration(),
          // CurrentPosition(),
          // PlayPauseButton(),
          // PlaybackSpeedButton(),
          // ProgressBar(),
        ],
        onEnded: (data) => data.toString(),
      ),
    );
  }
}
