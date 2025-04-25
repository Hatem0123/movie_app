import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app1/bloc/bloc_states/movie_details_states/movie_details_states.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app1/network/api_key/api_key.dart';
class Movies_details_Cubit extends Cubit<Movie_details_states>{

  Movies_details_Cubit():super(Movie_details_init_state());

  static Movies_details_Cubit get(context)=>BlocProvider.of(context);


  List<Map<String, dynamic>> Moviedetails = [];
  List<Map<String, dynamic>> UserReviews = [];
  List<Map<String, dynamic>> similarMovieList = [];
  List<Map<String, dynamic>> recomendedMovieList = [];
  List<Map<String, dynamic>> MovieTrailer = [];

  List<dynamic> Moviesgeners = [];


  Future<void> Get_Movie_details({var widget}) async {

    try {
      var Movies_Detail_URL =
          'https://api.themoviedb.org/3/movie/${widget.movie_id}?api_key=$api_key';


      emit(Movie_details_loading_state());
     // emit(Geners_Movie_details_loading_state());

      http.get(Uri.parse(Movies_Detail_URL)).then((value) async {

        if (value.statusCode == 200) {

          final movieDetailJson = jsonDecode(value.body);
          Moviedetails.add({
            "backdrop_path": movieDetailJson['backdrop_path'],
            "title": movieDetailJson['title'],
            "vote_average": movieDetailJson['vote_average'],
            "overview": movieDetailJson['overview'],
            "release_date": movieDetailJson['release_date'],
            "runtime": movieDetailJson['runtime'],
            "budget": movieDetailJson['budget'],
            "revenue": movieDetailJson['revenue'],
          });

          // ✅ Store genres safely
          Moviesgeners.clear(); // Clear previous data to prevent duplication
          Moviesgeners.addAll(
            (movieDetailJson['genres'] as List?)
                ?.map((genre) => genre['name'].toString())
                .toList() ?? [],
          );


          print("✅ Genres: $Moviesgeners");
        }
        emit(Movie_details_sucess_state());
       // emit(Geners_Movie_details_sucess_state());

      }).catchError((err) {
        emit(Movie_details_error_state(err.toString()));
      //  emit(Geners_Movie_details_error_state(err.toString()));
        print(err.toString());
      });

    }catch(e){

      print(e.toString());
    }







    print("✅ Finished fetching all data.");



  }

 // Future<void> Get_geners({var widget})async{}
  Future<void> Get_reviews({var widget})async{
    var User_review_URL =
        'https://api.themoviedb.org/3/movie/${widget
        .movie_id}/reviews?api_key=$api_key';

    emit(User_Review_Search_loading_state());
    http.get(Uri.parse(User_review_URL)).then((value) async {
      print("📝 User Reviews Status: ${value.statusCode}");


      if (value.statusCode == 200) {

        var reviewsData = await jsonDecode(value.body);
        UserReviews = (reviewsData['results'] as List?)?.map((review) =>
        {
          'name': review['author'] ?? 'Anonymous',
          'review': review['content'] ?? 'No review available',
          'rating': review['author_details']['rating']?.toString() ??
              'Not rated',
          'avatarphoto': (review['author_details']['avatar_path'] ?? '')
              .isEmpty
              ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
              : 'https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}',
          'creationdate': review['created_at']?.toString() ?? 'Unknown',
          'full_review_url': review['url'] ?? 'No URL available',
        }).toList() ?? [];
        print("✅ User Revies Details: ${UserReviews}");


      }
      emit(User_Review_get_Search_sucess_state());
    }).catchError((err) {
      emit(User_Review_get_Search_error_state(err.toString()));
      print(err.toString());
    });



  }


  Future<void> Get_movie_trailer({var widget})async{
    emit(Trailer_UI_loading_state());
    var Movie_trailer_URL =
        'https://api.themoviedb.org/3/movie/${widget
        .movie_id}/videos?api_key=$api_key';
    http.get(Uri.parse(Movie_trailer_URL)).then((value) async {
      print("📹 Trailers Status: ${value.statusCode}");

      if (value.statusCode == 200) {

        var trailerData = await jsonDecode(value.body);
        MovieTrailer = (trailerData['results'] as List?)
            ?.where((video) => video['type'] == "Trailer")
            .map((video) => {"key": video['key']})
            .toList() ?? [];
        print("✅ Trailers Details: ${MovieTrailer.toString()}");
      }
      emit(Trailer_UI_get_sucess_state());

    }).catchError((err) {
      emit(Trailer_UI_get_error_state(err.toString()));
      print(err.toString());
    });

  }
Future<void> Get_similar({var widget})async{
  emit(Similar_Movie_details_loading_state());
  var Simliar_movie_URL =
      'https://api.themoviedb.org/3/movie/${widget
      .movie_id}/similar?api_key=$api_key';
  http.get(Uri.parse(Simliar_movie_URL)).then((value) async {
    if (value.statusCode == 200) {

      var similarmoviesjson = await jsonDecode(value.body);

      similarMovieList = (similarmoviesjson['results'] as List?)
          ?.map((movie) =>
      {
        "poster_path": movie['poster_path'],
        "name": movie['title'],
        "vote_average": movie['vote_average'],
        "Date": movie['release_date'],
        "id": movie['id'],
      })
          .toList() ?? [];
    }
    emit(Similar_Movie_details_sucess_state());
  }).catchError((err) {
    emit(Similar_Movie_details_error_state(err.toString()));

    print(err.toString());
  });

}
Future<void> Get_recomended({var widget})async{

  var Recomended_movie_URL =
      'https://api.themoviedb.org/3/movie/${widget
      .movie_id}/recommendations?api_key=$api_key';
  emit(Recomended_Movie_details_loading_state());

  http.get(Uri.parse(Recomended_movie_URL)).then((value) async {
    if (value.statusCode == 200) {

      var recommendedmoviesjson = await jsonDecode(value.body);

      recomendedMovieList = (recommendedmoviesjson['results'] as List?)
          ?.map((movie) =>
      {
        "poster_path": movie['poster_path'],
        "name": movie['title'],
        "vote_average": movie['vote_average'],
        "Date": movie['release_date'],
        "id": movie['id'],
      })
          .toList() ?? [];
    }

    emit(Recomended_Movie_details_sucess_state());


  }).catchError((err) {
    emit(Recomended_Movie_details_error_state(err.toString()));
    print(err.toString());
  });
}
}













///Movie details method fetching all the lists
/*
Future<void> Get_Movie_details({var widget}) async {

    try {
      var Movies_Detail_URL =
          'https://api.themoviedb.org/3/movie/${widget.movie_id}?api_key=$api_key';

      var User_review_URL =
          'https://api.themoviedb.org/3/movie/${widget
          .movie_id}/reviews?api_key=$api_key';
      var Simliar_movie_URL =
          'https://api.themoviedb.org/3/movie/${widget
          .movie_id}/similar?api_key=$api_key';

      var Recomended_movie_URL =
          'https://api.themoviedb.org/3/movie/${widget
          .movie_id}/recommendations?api_key=$api_key';


      var Movie_trailer_URL =
          'https://api.themoviedb.org/3/movie/${widget
          .movie_id}/videos?api_key=$api_key';

      emit(Movie_details_loading_state());
      emit(Geners_Movie_details_loading_state());
      emit(User_Review_Search_loading_state());
      emit(Geners_Movie_details_loading_state());
      emit(Similar_Movie_details_loading_state());
      emit(Recomended_Movie_details_loading_state());

      http.get(Uri.parse(Movies_Detail_URL)).then((value) async {

        if (value.statusCode == 200) {

          final movieDetailJson = jsonDecode(value.body);
          Moviedetails.add({
            "backdrop_path": movieDetailJson['backdrop_path'],
            "title": movieDetailJson['title'],
            "vote_average": movieDetailJson['vote_average'],
            "overview": movieDetailJson['overview'],
            "release_date": movieDetailJson['release_date'],
            "runtime": movieDetailJson['runtime'],
            "budget": movieDetailJson['budget'],
            "revenue": movieDetailJson['revenue'],
          });

          // ✅ Store genres safely
          Moviesgeners.clear(); // Clear previous data to prevent duplication
          Moviesgeners.addAll(
            (movieDetailJson['genres'] as List?)
                ?.map((genre) => genre['name'].toString())
                .toList() ?? [],
          );


          print("✅ Genres: $Moviesgeners");
        }
        emit(Movie_details_sucess_state());
        emit(Geners_Movie_details_sucess_state());

      }).catchError((err) {
        emit(Movie_details_error_state(err.toString()));
        emit(Geners_Movie_details_error_state(err.toString()));
        print(err.toString());
      });


      http.get(Uri.parse(User_review_URL)).then((value) async {
        print("📝 User Reviews Status: ${value.statusCode}");


        if (value.statusCode == 200) {

          var reviewsData = await jsonDecode(value.body);
          UserReviews = (reviewsData['results'] as List?)?.map((review) =>
          {
            'name': review['author'] ?? 'Anonymous',
            'review': review['content'] ?? 'No review available',
            'rating': review['author_details']['rating']?.toString() ??
                'Not rated',
            'avatarphoto': (review['author_details']['avatar_path'] ?? '')
                .isEmpty
                ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                : 'https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}',
            'creationdate': review['created_at']?.toString() ?? 'Unknown',
            'full_review_url': review['url'] ?? 'No URL available',
          }).toList() ?? [];
          print("✅ User Revies Details: ${UserReviews}");


        }
        emit(User_Review_get_Search_sucess_state());
      }).catchError((err) {
        emit(User_Review_get_Search_error_state(err.toString()));
        print(err.toString());
      });

      http.get(Uri.parse(Movie_trailer_URL)).then((value) async {
        print("📹 Trailers Status: ${value.statusCode}");

        if (value.statusCode == 200) {

          var trailerData = await jsonDecode(value.body);
          MovieTrailer = (trailerData['results'] as List?)
              ?.where((video) => video['type'] == "Trailer")
              .map((video) => {"key": video['key']})
              .toList() ?? [];
          print("✅ Trailers Details: ${MovieTrailer.toString()}");
        }
        emit(Trailer_UI_get_sucess_state());

      }).catchError((err) {
        emit(Trailer_UI_get_error_state(err.toString()));
        print(err.toString());
      });

      http.get(Uri.parse(Simliar_movie_URL)).then((value) async {
        if (value.statusCode == 200) {

          var similarmoviesjson = await jsonDecode(value.body);

          similarMovieList = (similarmoviesjson['results'] as List?)
              ?.map((movie) =>
          {
            "poster_path": movie['poster_path'],
            "name": movie['title'],
            "vote_average": movie['vote_average'],
            "Date": movie['release_date'],
            "id": movie['id'],
          })
              .toList() ?? [];
        }
        emit(Similar_Movie_details_sucess_state());
      }).catchError((err) {
        emit(Similar_Movie_details_error_state(err.toString()));

        print(err.toString());
      });


      http.get(Uri.parse(Recomended_movie_URL)).then((value) async {
        if (value.statusCode == 200) {

          var recommendedmoviesjson = await jsonDecode(value.body);

          recomendedMovieList = (recommendedmoviesjson['results'] as List?)
              ?.map((movie) =>
          {
            "poster_path": movie['poster_path'],
            "name": movie['title'],
            "vote_average": movie['vote_average'],
            "Date": movie['release_date'],
            "id": movie['id'],
          })
              .toList() ?? [];
        }

        emit(Recomended_Movie_details_sucess_state());


      }).catchError((err) {
        emit(Recomended_Movie_details_error_state(err.toString()));
        print(err.toString());
      });
    }catch(e){

      print(e.toString());
    }







    print("✅ Finished fetching all data.");



  }
 */
