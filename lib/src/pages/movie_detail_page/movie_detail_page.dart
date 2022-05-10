import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_movies_app/src/constants/assets.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/utils/models/movie.dart';
import 'package:my_movies_app/src/utils/services/movies_service.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();

  final Movie movie;
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBlackColor,
      body: CustomScrollView(
        key: const Key('movieDetailScrollView'),
        slivers: [
          SliverAppBar(
            backgroundColor: colors.kBlackColor,
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeIn(
                duration: const Duration(milliseconds: 500),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 1.0, 1.0],
                    ).createShader(
                      Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        fontSize: 23,
                        color: colors.kWhiteColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: colors.kWhiteColor,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            widget.movie.releaseDate!.split('-')[0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: colors.kBlackColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              (widget.movie.voteAverage!).toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: colors.kWhiteColor,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '(${widget.movie.voteAverage})',
                              style: TextStyle(
                                fontSize: 1.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: colors.kWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      widget.movie.overview ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                        color: colors.kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
            sliver: SliverToBoxAdapter(
              child: FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'More like this'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: colors.kWhiteColor,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
            sliver: _showRecommendations(),
          ),
        ],
      ),
    );
  }

  _showRecommendations() {
    return FutureBuilder(
      future: moviesServices.getRelatedMovies(widget.movie.id!),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = snapshot.data![index];
                return FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailPage(movie: recommendation),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original/${recommendation.posterPath}",
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              childCount: snapshot.data!.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 3
                      : 4,
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Lottie.asset(
                Assets.kLoader,
              ),
            ),
          );
        }
      },
    );
  }
}
