import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_movies_app/src/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:my_movies_app/src/utils/models/movie.dart';

class MoviesService {
  String baseUrl = Apis.moviesApi;
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

  Future<List<Movie>> getRelatedMovies(int movieID) async {
    var url = Uri.https(baseUrl, '/3/movie/$movieID/similar');
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

  Future<List<Movie>> getQueryMovies(String query) async {
    var url = Uri.https(
      baseUrl,
      '/3/search/movie',
      {
        'api_key': "c8001eef492af921b62625adc13e1d13",
        'query': query,
      },
    );

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
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

MoviesService moviesServices = MoviesService();
