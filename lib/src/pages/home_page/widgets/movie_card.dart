import 'package:flutter/material.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/pages/movie_detail_page/movie_detail_page.dart';
import 'package:my_movies_app/src/utils/models/movie.dart';

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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: movie),
          ),
        );
      },
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
