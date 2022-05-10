import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_movies_app/src/constants/assets.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/utils/models/movie.dart';
import 'package:my_movies_app/src/utils/services/movies_service.dart';
import 'package:my_movies_app/src/widgets/inputs/search_input.dart';

import 'widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset(
                          Assets.kLoader,
                        ),
                      );
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
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset(
                          Assets.kLoader,
                        ),
                      );
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

