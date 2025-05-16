import 'package:flutter/material.dart';
import 'package:moviematch/models/movie.dart';
import 'package:moviematch/providers/moviematch.dart';
import 'package:moviematch/providers/my_app_state.dart';
import 'package:moviematch/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatefulWidget {
  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  final TextEditingController controller = TextEditingController();

  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = context.read<MyAppState>().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var movieState = context.watch<MovieMatchProvider>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Movie>>(
            future: _movies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError &&
                  snapshot.hasData) {
                return SwipeableCards(snapshot.data!);
              }

              return Text("No movies at this time :(");
            },
          ),
          Text("${movieState.userName}"),
          TextFormField(controller: controller),
          TextButton(
            onPressed: () {
              print("${controller.text}");

              movieState.setUserName(controller.text);
            },
            child: Text("save username"),
          ),
        ],
      ),
    );
  }
}
