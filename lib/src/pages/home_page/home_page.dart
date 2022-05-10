import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/utils/models/movie.dart';
import 'package:my_movies_app/src/utils/services/movies_service.dart';
import 'package:my_movies_app/src/widgets/inputs/search_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colors.kBlackColor,
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.kGreenColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.4,
            right: -88,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.kPinkColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 166,
                  width: 166,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.kCyanColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'What would you\nlike to watch?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: colors.kWhiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SearchFieldWidget(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                ),
                const SizedBox(
                  height: 39,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Popular movies',
                    style: TextStyle(
                      color: colors.kWhiteColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 37,
                ),
                FutureBuilder(
                  future: moviesServices.getPopularMovies(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Movie>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Movie> popularMovies = snapshot.data ?? [];

                      return SizedBox(
                        height: 170,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: popularMovies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              index: index,
                              movie: popularMovies[index],
                            );
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  height: 38,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Upcoming movies',
                    style: TextStyle(
                      color: colors.kWhiteColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 37,
                ),
                 FutureBuilder(
                  future: moviesServices.getUpcomingMovies(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Movie>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Movie> upcomingMovies = snapshot.data ?? [];

                      return SizedBox(
                        height: 170,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingMovies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              index: index,
                              movie: upcomingMovies[index],
                            );
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
               
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.index,
    required this.movie,
  }) : super(key: key);

  final int index;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
          left: index == 0 ? 20 : 0,
        ),
        height: 170,
        width: 142,
        decoration: BoxDecoration(
          color: colors.kBlackColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://image.tmdb.org/t/p/original/${movie.posterPath}",
            ),
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colors.kBlackColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: TextStyle(
                      color: colors.kWhiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        movie.releaseDate ?? '',
                        style: TextStyle(
                          color: colors.kWhiteColor,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        movie.voteAverage?.toStringAsFixed(1) ?? '',
                        style: TextStyle(
                          color: colors.kWhiteColor,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: colors.kWhiteColor,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
