import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/pages/movie_detail_page/movie_detail_page.dart';
import 'package:my_movies_app/src/utils/models/movie.dart';

class ItemCard extends StatelessWidget {
  final Movie movie;

  const ItemCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

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
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '-',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                      color: colors.kWhiteColor,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: colors.kBlackColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          movie.releaseDate!.split('-')[0],
                          style: TextStyle(
                            color: colors.kWhiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        (movie.voteAverage!).toStringAsFixed(1),
                        style: TextStyle(
                          color: colors.kWhiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    movie.overview ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: colors.kWhiteColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
