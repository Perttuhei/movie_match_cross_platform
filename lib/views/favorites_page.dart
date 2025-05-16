import 'package:flutter/material.dart';
import 'package:moviematch/providers/moviematch.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    var movieState = context.watch<MovieMatchProvider>();

    if (movieState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${movieState.favorites.length} favorites:'),
        ),
        for (var movie in movieState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(movie),
          ),
      ],
    );
  }
}
