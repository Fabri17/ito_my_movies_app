import 'package:flutter/material.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/utils/models/movie.dart';
import 'package:my_movies_app/src/utils/services/movies_service.dart';
import 'package:my_movies_app/src/widgets/inputs/search_input.dart';

import 'widgets/item_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    moviesServices.getUpcomingMovies().then((value) {
      setState(() {
        _movies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBlackColor,
      appBar: AppBar(
        title: const Text('Search Movie'),
        backgroundColor: colors.kBlackColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          SearchFieldWidget(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onChange: (value) => _search(value),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: _movies.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return ItemCard(
                    movie: movie,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _search(String value) async {
    if (value.isEmpty) {
      _movies = await moviesServices.getUpcomingMovies();
    } else {
      _movies = await moviesServices.getQueryMovies(value);
    }

    setState(() {});
  }
}
