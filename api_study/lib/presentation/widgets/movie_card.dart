import 'package:api_study/core/constants.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String movieId;
  final String? posterPath;
  final String? movieTitle;
  final void Function()? onTap;

  const MovieCard({
    Key? key,
    required this.movieId,
    this.posterPath,
    this.onTap,
    this.movieTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterUrl =
        'https://image.tmdb.org/t/p/w220_and_h330_face$posterPath';

    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: movieId,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(
                posterPath != null ? posterUrl : coverPlaceholder,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
