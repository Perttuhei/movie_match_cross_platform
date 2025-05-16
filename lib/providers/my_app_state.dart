import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:moviematch/models/movie.dart';

class MyAppState extends ChangeNotifier {
  List<Movie> movies = [];
  
  var current = WordPair.random();
  String currentTitle = "Loading...";
  late final String readAccessKey;

  MyAppState() {
    String? key = dotenv.env["TMDB_READ_ACCESS_KEY"];

    if (key == null) {
      throw Exception(
        "No read access key found in app_state init, does .env exist?",
      );
    }

    readAccessKey = key;
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  // Add import to top of the file: import 'package:http/http.dart' as http;
  Future<List<Movie>> fetchMovies() async {
    final Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular");

    var response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $readAccessKey",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    var data = jsonDecode(response.body) as Map<String, dynamic>;

    List moviesJson = data["results"];

    movies = moviesJson.map((movieJson) => Movie.fromJson(movieJson)).toList();

    return movies;
  }
}
