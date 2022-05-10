import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_movies_app/src/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:my_movies_app/src/utils/models/movie.dart';

class MoviesServices {
  String baseUrl = Apis.MOVIES_API;
  String accessToken = dotenv.env['MOVIES_ACCESS_TOKEN']!;

  Future<List<Movie>> getPopularMovies() async {
    var url = Uri.https(baseUrl, '/3/movie/popular');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    List<Movie> movies = [];
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var i = 0; i < json['results'].length; i++) {
        movies.add(Movie.fromJson(json['results'][i]));
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    return movies;
  }

  Future<List<Movie>> getUpcomingMovies() async {
    var url = Uri.https(baseUrl, '/3/movie/upcoming');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    List<Movie> movies = [];
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var i = 0; i < json['results'].length; i++) {
        movies.add(Movie.fromJson(json['results'][i]));
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    return movies;
  }
}

MoviesServices moviesServices = MoviesServices();
