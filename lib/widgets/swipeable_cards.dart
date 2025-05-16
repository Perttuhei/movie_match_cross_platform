import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:moviematch/models/movie.dart';
import 'package:moviematch/providers/moviematch.dart';
import 'package:provider/provider.dart';

class SwipeableCards extends StatelessWidget {
  final List<Movie> movies;

  SwipeableCards(this.movies);

  @override
  Widget build(BuildContext context) {

    var movieMatch = context.read<MovieMatchProvider>();

    if (movies.isEmpty) {
      return Text("No movies available");
    }

    return Flexible(
      child: CardSwiper(
        cardBuilder: (context, index, tresholdX, tresholdY) {
          var baseUrl = "https://image.tmdb.org/t/p/w500";
          var posterPath = movies[index].posterPath;
          var fullImageUrl = baseUrl + posterPath;

          return Container(
            alignment: Alignment.center,
            child: Image.network(fullImageUrl),
          );
        },
        cardsCount: movies.length,
        onSwipe: (oldIndex, currentIndex, direction) async {
          print("$oldIndex $currentIndex $direction");

          if (direction == CardSwiperDirection.right) {
            movieMatch.send(movies[oldIndex].originalTitle);
          }

          return true;
        },
        isLoop: false,
        allowedSwipeDirection: AllowedSwipeDirection.only(
          left: true,
          right: true,
        ),
      ),
    );
  }
}