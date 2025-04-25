import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/bloc_states/movie_details_states/movie_details_states.dart' as dd;
import 'package:movie_app1/bloc/bloc_states/movie_details_states/movie_details_states.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'package:movie_app1/bloc/block_logic/movie_details%20bloc/movie_details_bloc.dart';
import 'package:movie_app1/modules/home_screen/home.dart';
import 'package:movie_app1/modules/trailer_ui/trailer_ui.dart';
import 'package:movie_app1/modules/user_review/user_review.dart';
import 'package:movie_app1/network/api_key/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app1/shared/components/components.dart';

class Movies_details extends StatefulWidget {


  // static Future<Response> init_movie_details_response(){
  //
  //   var gh =http.get(Uri.parse('https://api.themoviedb.org/3/movie/'));
  //  return gh;
  // }
  var movie_id;
     Movies_details({this.movie_id});


  @override
  State<Movies_details> createState() => _Movies_detailsState();


}

class _Movies_detailsState extends State<Movies_details> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     App_cubit.get(context).MovieDetails(sad:widget.movie_id);
  //   });
  // }

  //List<Map<String, dynamic>> movietrailerslist = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   // var moviesCubit = App_cubit.get(context);
  //   // moviesCubit.MovieDetails(
  //   //   Movies_Detail_URL: 'https://api.themoviedb.org/3/movie/${widget.movie_id}?api_key=$api_key',
  //   //   User_review_URL: 'https://api.themoviedb.org/3/movie/${widget.movie_id}/reviews?api_key=$api_key',
  //   //   Simliar_movie_URL: 'https://api.themoviedb.org/3/movie/${widget.movie_id}/similar?api_key=$api_key',
  //   //   Recomended_movie_URL: 'https://api.themoviedb.org/3/movie/${widget.movie_id}/recommendations?api_key=$api_key',
  //   //   Movie_trailer_URL: 'https://api.themoviedb.org/3/movie/${widget.movie_id}/videos?api_key=$api_key',
  //   // );
  // }
   //Future<Object?>? Data;
  //
  // List<Map<String, dynamic>> Moviedetails = [];
  // List<Map<String, dynamic>> UserReviews = [];
  // List<Map<String, dynamic>> similarMovieList = [];
  // List<Map<String, dynamic>> recomendedMovieList = [];
  // List<Map<String, dynamic>> MovieTrailer = [];
  //
  // List<dynamic> Moviesgeners = [];
  //
  // Future<void> MovieDetailss() async {
  //
  //   // var Movies_Detail_URL =
  //   //     'https://api.themoviedb.org/3/movie/${widget
  //   //     .movie_id}?api_key=$api_key';
  //   //
  //   // var User_review_URL =
  //   //     'https://api.themoviedb.org/3/movie/${widget
  //   //     .movie_id}/reviews?api_key=$api_key';
  //   // var Simliar_movie_URL =
  //   //     'https://api.themoviedb.org/3/movie/${widget
  //   //     .movie_id}/similar?api_key=$api_key';
  //   //
  //   // var Recomended_movie_URL =
  //   //     'https://api.themoviedb.org/3/movie/${widget
  //   //     .movie_id}/recommendations?api_key=$api_key';
  //   //
  //   //
  //   // var Movie_trailer_URL =
  //   //     'https://api.themoviedb.org/3/movie/${widget
  //   //     .movie_id}/videos?api_key=$api_key';
  //
  //
  //   ///Popular logic
  //   print("🔄 Starting MovieDetails fetch...");
  //   try {
  //     final Movies_Detail_URL = 'https://api.themoviedb.org/3/movie/${widget.movie_id}?api_key=$api_key';
  //     final User_review_URL = 'https://api.themoviedb.org/3/movie/${widget.movie_id}/reviews?api_key=$api_key';
  //     final Simliar_movie_URL = 'https://api.themoviedb.org/3/movie/${widget.movie_id}/similar?api_key=$api_key';
  //     final Recomended_movie_URL = 'https://api.themoviedb.org/3/movie/${widget.movie_id}/recommendations?api_key=$api_key';
  //     final Movie_trailer_URL = 'https://api.themoviedb.org/3/movie/${widget.movie_id}/videos?api_key=$api_key';
  //
  //     /// ✅ Fetch all data in parallel
  //     final responses = await Future.wait([
  //       http.get(Uri.parse(Movies_Detail_URL)),  // Movie details
  //       http.get(Uri.parse(User_review_URL)),   // Reviews
  //       http.get(Uri.parse(Movie_trailer_URL)), // Trailers
  //       http.get(Uri.parse(Simliar_movie_URL)), // Similar movies
  //       http.get(Uri.parse(Recomended_movie_URL)) // Recommended movies
  //     ]);
  //
  //     final movieDetailResponse = responses[0];
  //     final reviewsResponse = responses[1];
  //     final trailerResponse = responses[2];
  //     final similarMoviesResponse = responses[3];
  //     final recommendedMoviesResponse = responses[4];
  //
  //
  //     final movieData = jsonDecode(movieDetailResponse.body);
  //     if (movieDetailResponse.statusCode == 200) {
  //
  //       for (var i = 0; i < 1; i++) {
  //         Moviedetails.add({
  //           "backdrop_path": movieData['backdrop_path'],
  //           "title": movieData['title'],
  //           "vote_average": movieData['vote_average'],
  //           "overview": movieData['overview'],
  //           "release_date": movieData['release_date'],
  //           "runtime": movieData['runtime'],
  //           "budget": movieData['budget'],
  //           "revenue": movieData['revenue'],
  //         });
  //       }
  //       for (var i = 0; i < movieData['genres'].length; i++) {
  //         Moviesgeners.add(movieData['genres'][i]['name']);
  //       }
  //     } else {}
  //
  //     // ✅ Fetch User Reviews
  //     //var reviewsResponse = await http.get(Uri.parse(User_review_URL));
  //
  //     print("📝 User Reviews Status: ${reviewsResponse.statusCode}");
  //     var reviewsData = await jsonDecode(reviewsResponse.body);
  //     if (reviewsResponse.statusCode == 200) {
  //
  //       UserReviews = (reviewsData['results'] as List?)?.map((review) =>
  //       {
  //         'name': review['author'] ?? 'Anonymous',
  //         'review': review['content'] ?? 'No review available',
  //         'rating': review['author_details']['rating']?.toString() ??
  //             'Not rated',
  //         'avatarphoto': (review['author_details']['avatar_path'] ?? '')
  //             .isEmpty
  //             ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
  //             : 'https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}',
  //         'creationdate': review['created_at']?.toString() ?? 'Unknown',
  //         'full_review_url': review['url'] ?? 'No URL available',
  //       }).toList() ?? [];
  //       print("✅ USER Revies Details: ${UserReviews}");
  //     }
  //
  //     // ✅ Fetch Trailers
  //     //var trailerResponse = await http.get(Uri.parse(Movie_trailer_URL));
  //     print("📹 Trailers Status: ${trailerResponse.statusCode}");
  //     var trailerData = jsonDecode(trailerResponse.body);
  //     if (trailerResponse.statusCode == 200) {
  //
  //       MovieTrailer = (trailerData['results'] as List?)
  //           ?.where((video) => video['type'] == "Trailer")
  //           .map((video) => {"key": video['key']})
  //           .toList() ?? [];
  //     }
  //
  //
  //     /////////////////////////////similar movies
  //     // var similarMoviesResponse = await http.get(Uri.parse(Simliar_movie_URL));
  //     var similarmoviesjson =  jsonDecode(similarMoviesResponse.body);
  //     if (similarMoviesResponse.statusCode == 200) {
  //
  //       for (var i = 0; i < similarmoviesjson['results'].length; i++) {
  //         similarMovieList.add({
  //           "poster_path": similarmoviesjson['results'][i]['poster_path'],
  //           "name": similarmoviesjson['results'][i]['title'],
  //           "vote_average": similarmoviesjson['results'][i]['vote_average'],
  //           "Date": similarmoviesjson['results'][i]['release_date'],
  //           "id": similarmoviesjson['results'][i]['id'],
  //         });
  //       }
  //     } else {}
  //     // print(similarmovieslist);
  //     /////////////////////////////recommended movies
  //     // var recommendedmoviesresponse =
  //     // await http.get(Uri.parse(Recomended_movie_URL));
  //     var recommendedmoviesjson =  jsonDecode(recommendedMoviesResponse.body);
  //     if (recommendedMoviesResponse.statusCode == 200) {
  //
  //       for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
  //         recomendedMovieList.add({
  //           "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
  //           "name": recommendedmoviesjson['results'][i]['title'],
  //           "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
  //           "Date": recommendedmoviesjson['results'][i]['release_date'],
  //           "id": recommendedmoviesjson['results'][i]['id'],
  //         });
  //       }
  //     } else {}
  //     // print(recommendedmovieslist);
  //
  //
  //
  //
  //
  //   } catch (e) {
  //     print("🚨 Exception: $e");
  //   }
  //
  //
  //   print("✅ Finished fetching all data.");
  //
  //
  //
  //   // print(movietrailerslist);
  //
  //
  //
  //
  //
  //
  //
  //
  // }
  /// MOvie Details Future set state method
  /*
  Future<void> MovieDetails(
    // var Movies_Detail_URL,
    // var User_review_URL,
    // var Simliar_movie_URL,
    // var Recomended_movie_URL,
    // var Movie_trailer_URL,
    )
  async {
    var Movies_Detail_URL =
        'https://api.themoviedb.org/3/movie/${widget
        .movie_id}?api_key=$api_key';

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


    http.get(Uri.parse(Movies_Detail_URL)).then((value)async{

      if (value.statusCode == 200) {
        final movieDetailJson = jsonDecode(value.body);

        setState(() {
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
        });

        print("✅ Genres: $Moviesgeners");
      }




      else {

      }


    }).catchError((err){
      print(err.toString());

    });


    http.get(Uri.parse(User_review_URL)).then((value)async{

      print("📝 User Reviews Status: ${value.statusCode}");

      if (value.statusCode == 200) {
        var reviewsData = await jsonDecode(value.body);

        setState(() {

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


        });




      }


    }).catchError((err){
      print(err.toString());

    });

    http.get(Uri.parse(Movie_trailer_URL)).then((value)async{




      print("📹 Trailers Status: ${value.statusCode}");

      if (value.statusCode == 200) {
        var trailerData =await jsonDecode(value.body);
        setState(() {

          MovieTrailer = (trailerData['results'] as List?)
              ?.where((video) => video['type'] == "Trailer")
              .map((video) => {"key": video['key']})
              .toList() ?? [];
          print("✅ Trailers Details: ${MovieTrailer.toString()}");
        });



      }


    }).catchError((err){
      print(err.toString());

    });

    http.get(Uri.parse(Simliar_movie_URL)).then((value)async{

      if (value.statusCode == 200) {
        var similarmoviesjson = await jsonDecode(value.body);
        setState(() {


        });

        similarMovieList = (similarmoviesjson['results'] as List?)
            ?.map((movie) => {
          "poster_path": movie['poster_path'],
          "name": movie['title'],
          "vote_average": movie['vote_average'],
          "Date": movie['release_date'],
          "id": movie['id'],
        })
            .toList() ?? [];

      } else {}


    }).catchError((err){
      print(err.toString());

    });


    http.get(Uri.parse(Recomended_movie_URL)).then((value)async{

      if (value.statusCode == 200) {
        var recommendedmoviesjson = await jsonDecode(value.body);

        recomendedMovieList = (recommendedmoviesjson['results'] as List?)
            ?.map((movie) => {
          "poster_path": movie['poster_path'],
          "name": movie['title'],
          "vote_average": movie['vote_average'],
          "Date": movie['release_date'],
          "id": movie['id'],
        })
            .toList() ?? [];
      }
      else {}


    }).catchError((err){

      print(err.toString());

    });






    print("✅ Finished fetching all data.");



  }




   */

  // List<Map<String, dynamic>> Moviedetails = [];
  // List<Map<String, dynamic>> UserReviews = [];
  // List<Map<String, dynamic>> similarMovieList = [];
  // List<Map<String, dynamic>> recomendedMovieList = [];
  // List<Map<String, dynamic>> MovieTrailer = [];
  //
  // List<dynamic> Moviesgeners = [];




  // Future<void> MovieDetails(
  //     // var Movies_Detail_URL,
  //     // var User_review_URL,
  //     // var Simliar_movie_URL,
  //     // var Recomended_movie_URL,
  //     // var Movie_trailer_URL,
  //     )
  // async {
  //
  //       try {
  //         var Movies_Detail_URL =
  //             'https://api.themoviedb.org/3/movie/${widget
  //             .movie_id}?api_key=$api_key';
  //
  //         var User_review_URL =
  //             'https://api.themoviedb.org/3/movie/${widget
  //             .movie_id}/reviews?api_key=$api_key';
  //         var Simliar_movie_URL =
  //             'https://api.themoviedb.org/3/movie/${widget
  //             .movie_id}/similar?api_key=$api_key';
  //
  //         var Recomended_movie_URL =
  //             'https://api.themoviedb.org/3/movie/${widget
  //             .movie_id}/recommendations?api_key=$api_key';
  //
  //
  //         var Movie_trailer_URL =
  //             'https://api.themoviedb.org/3/movie/${widget
  //             .movie_id}/videos?api_key=$api_key';
  //
  //
  //
  //         http.get(Uri.parse(Movies_Detail_URL)).then((value) async {
  //           if (value.statusCode == 200) {
  //             setState(() {
  //
  //             });
  //             final movieDetailJson = jsonDecode(value.body);
  //             Moviedetails.add({
  //               "backdrop_path": movieDetailJson['backdrop_path'],
  //               "title": movieDetailJson['title'],
  //               "vote_average": movieDetailJson['vote_average'],
  //               "overview": movieDetailJson['overview'],
  //               "release_date": movieDetailJson['release_date'],
  //               "runtime": movieDetailJson['runtime'],
  //               "budget": movieDetailJson['budget'],
  //               "revenue": movieDetailJson['revenue'],
  //             });
  //
  //             // ✅ Store genres safely
  //             Moviesgeners.clear(); // Clear previous data to prevent duplication
  //             Moviesgeners.addAll(
  //               (movieDetailJson['genres'] as List?)
  //                   ?.map((genre) => genre['name'].toString())
  //                   .toList() ?? [],
  //             );
  //
  //
  //             print("✅ Genres: $Moviesgeners");
  //           }
  //         }).catchError((err) {
  //           print(err.toString());
  //         });
  //
  //
  //         http.get(Uri.parse(User_review_URL)).then((value) async {
  //           print("📝 User Reviews Status: ${value.statusCode}");
  //
  //
  //           if (value.statusCode == 200) {
  //             setState(() {
  //
  //             });
  //             var reviewsData = await jsonDecode(value.body);
  //             UserReviews = (reviewsData['results'] as List?)?.map((review) =>
  //             {
  //               'name': review['author'] ?? 'Anonymous',
  //               'review': review['content'] ?? 'No review available',
  //               'rating': review['author_details']['rating']?.toString() ??
  //                   'Not rated',
  //               'avatarphoto': (review['author_details']['avatar_path'] ?? '')
  //                   .isEmpty
  //                   ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
  //                   : 'https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}',
  //               'creationdate': review['created_at']?.toString() ?? 'Unknown',
  //               'full_review_url': review['url'] ?? 'No URL available',
  //             }).toList() ?? [];
  //             print("✅ User Revies Details: ${UserReviews}");
  //           }
  //         }).catchError((err) {
  //           print(err.toString());
  //         });
  //
  //         http.get(Uri.parse(Movie_trailer_URL)).then((value) async {
  //           print("📹 Trailers Status: ${value.statusCode}");
  //
  //           if (value.statusCode == 200) {
  //             setState(() {
  //
  //             });
  //             var trailerData = await jsonDecode(value.body);
  //             MovieTrailer = (trailerData['results'] as List?)
  //                 ?.where((video) => video['type'] == "Trailer")
  //                 .map((video) => {"key": video['key']})
  //                 .toList() ?? [];
  //             print("✅ Trailers Details: ${MovieTrailer.toString()}");
  //           }
  //         }).catchError((err) {
  //           print(err.toString());
  //         });
  //
  //         http.get(Uri.parse(Simliar_movie_URL)).then((value) async {
  //           if (value.statusCode == 200) {
  //             setState(() {
  //
  //             });
  //             var similarmoviesjson = await jsonDecode(value.body);
  //
  //             similarMovieList = (similarmoviesjson['results'] as List?)
  //                 ?.map((movie) =>
  //             {
  //               "poster_path": movie['poster_path'],
  //               "name": movie['title'],
  //               "vote_average": movie['vote_average'],
  //               "Date": movie['release_date'],
  //               "id": movie['id'],
  //             })
  //                 .toList() ?? [];
  //           } else {}
  //         }).catchError((err) {
  //           print(err.toString());
  //         });
  //
  //
  //         http.get(Uri.parse(Recomended_movie_URL)).then((value) async {
  //           if (value.statusCode == 200) {
  //             setState(() {
  //
  //             });
  //             var recommendedmoviesjson = await jsonDecode(value.body);
  //
  //             recomendedMovieList = (recommendedmoviesjson['results'] as List?)
  //                 ?.map((movie) =>
  //             {
  //               "poster_path": movie['poster_path'],
  //               "name": movie['title'],
  //               "vote_average": movie['vote_average'],
  //               "Date": movie['release_date'],
  //               "id": movie['id'],
  //             })
  //                 .toList() ?? [];
  //           }
  //           else {}
  //         }).catchError((err) {
  //           print(err.toString());
  //         });
  //       }catch(e){
  //
  //         print(e.toString());
  //       }
  //
  //
  //
  //
  //
  //
  //
  //   print("✅ Finished fetching all data.");
  //
  //
  //
  // }

  List<Map<String, dynamic>> Moviedetails = [];
  List<Map<String, dynamic>> UserReviews = [];
  List<Map<String, dynamic>> similarMovieList = [];
  List<Map<String, dynamic>> recomendedMovieList = [];
  List<Map<String, dynamic>> MovieTrailer = [];

  List<dynamic> Moviesgeners = [];


  Future<void> Get_Movie_details() async {

    try {
      var Movies_Detail_URL =
          'https://api.themoviedb.org/3/movie/${widget.movie_id}?api_key=$api_key';

      // emit(Geners_Movie_details_loading_state());

      http.get(Uri.parse(Movies_Detail_URL)).then((value) async {
        if (value.statusCode == 200) {
               final movieDetailJson =  jsonDecode(value.body);
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

        // emit(Geners_Movie_details_sucess_state());

      }).catchError((err) {

        //  emit(Geners_Movie_details_error_state(err.toString()));
        print(err.toString());
      });

    }
     on RangeError{
       print("Fetcing Data");
     }
    catch(e){

      print(e.toString());
    }







    print("✅ Finished fetching all data.");


    setState(() {
    });

  }

  // Future<void> Get_geners({var widget})async{}

  Future<void> Get_reviews()async{
    var User_review_URL =
        'https://api.themoviedb.org/3/movie/${widget
        .movie_id}/reviews?api_key=$api_key';


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

    }).catchError((err) {

      print(err.toString());
    });



  }
  Future<void> Get_movie_trailer()async{

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


    }).catchError((err) {

      print(err.toString());
    });

  }
  Future<void> Get_similar()async{

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

    }).catchError((err) {


      print(err.toString());
    });

  }
  Future<void> Get_recomended()async{

    var Recomended_movie_URL =
        'https://api.themoviedb.org/3/movie/${widget
        .movie_id}/recommendations?api_key=$api_key';


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




    }).catchError((err) {

      print(err.toString());
    });
  }
 

Future<void> Call_all()async {

  await Get_Movie_details();
   await Get_reviews();
 await  Get_movie_trailer();
 await  Get_similar();
 await  Get_recomended();

}
  @override
  Widget build(BuildContext context) {
    // var cubit_movie_details = App_cubit
    //     .get(context)
    //     .Moviedetails;
    // var cubit_movie_geners = App_cubit
    //     .get(context)
    //     .Moviesgeners;
    // var cubit_movie_user_review = App_cubit
    //     .get(context)
    //     .UserReviews;
    // var cubit_movie_trailer = App_cubit
    //     .get(context)
    //     .MovieTrailer;
    // var cubit_movie_recomended = App_cubit
    //     .get(context)
    //     .recomendedMovieList;
    // var cubit_movie_similar = App_cubit
    //     .get(context)
    //     .similarMovieList;
    // var fun = App_cubit.get(context).MovieDetails(sad: widget.movie_id);

    // Future<void> _handle_refresh() async {
    //   return await Future.delayed(Duration(seconds: 1));
    // }

    /*
    LiquidPullToRefresh(

       onRefresh:_handle_refresh ,
       color: Colors.black26,
       animSpeedFactor: 2,
       showChildOpacityTransition: true,
       child:details_secreneto(context: context,
     */



    // Get Cubit instance



    return

      FutureBuilder(
        future:Call_all() ,
        builder: (context,snapshot) {
          try{
            return Scaffold(
                body:CustomScrollView(
                    scrollDirection: Axis.vertical,
                    dragStartBehavior:DragStartBehavior.start ,

                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                          automaticallyImplyLeading: false,
                          leading: IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                        builder: (context) => Home_screen()),
                                        (route) => false);
                              },
                              icon: Icon(FontAwesomeIcons.circleArrowLeft),
                              iconSize: 28,
                              color: Colors.white),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home_screen()),
                                          (route) => false);
                                },
                                icon: Icon(FontAwesomeIcons.houseUser),
                                iconSize: 25,
                                color: Colors.white)
                          ],
                          backgroundColor: Colors.black,
                          centerTitle: false,
                          pinned: true,
                          expandedHeight:
                          MediaQuery.of(context).size.height * 0.4,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: FittedBox(
                              fit: BoxFit.cover,
                              child: MovieTrailer.isNotEmpty
                                  ? trailerwatch(MovieTrailer[0]['key'])
                                  : CircularProgressIndicator(color: Colors.black26,),
                            ),
                          )),
                      SliverList(
                          delegate: SliverChildListDelegate([
                            Column(
                              children: [
                                Row(children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: Moviesgeners.length,
                                          itemBuilder: (context, index) {
                                            //generes box
                                            return Container(
                                                margin: EdgeInsets.only(right: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                    Colors.white70,
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Text('${Moviesgeners[index]}'));
                                          })),
                                ]),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(left: 10, top: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Text(
                                            '${Moviedetails[0]['runtime']} min'))
                                  ],
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Text('Movie Story :',style:TextStyle(color:Colors.white70))),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Text('${Moviedetails[0]['overview'].toString()}',style:TextStyle(color:Colors.white70),)

                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: UserReview(UserReviews),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 20),
                                child: Text('Release Date : ${Moviedetails[0]['release_date']}',style:TextStyle(color:Colors.white70))),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 20),
                                child: Text('Budget : ${Moviedetails[0]['budget']}',style:TextStyle(color:Colors.white70))),
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 20),
                                child: Text('Revenue : ${Moviedetails[0]['revenue']}',style:TextStyle(color:Colors.white70))),

                            slider_list(similarMovieList, "Similar Movies", "movie",
                                similarMovieList.length),
                            slider_list(recomendedMovieList, "Recommended Movies",
                                "movie", recomendedMovieList.length),
                            // Container(
                            //     height: 50,
                            //     child: Center(child: normaltext("By Niranjan Dahal")))
                          ])



                      )
                    ])


            );
          }on RangeError{
            return Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
          }


        }


          ,

      );



  }
}

/*
 details_secreneto(method_name: cubit.MovieDetails(sad: widget.movie_id),
              deatils_list_name: cubit.Moviedetails,
              genersListName: cubit.Moviesgeners,
              user_reviews_ListName: cubit.UserReviews,
              trailerListName: cubit.MovieTrailer,
              recomende_ListName: cubit.recomendedMovieList,
              similar_ListName: cubit.similarMovieList
          )
 */

/*
scafold body{

  body: FutureBuilder(future: cubit.MovieDetails(sad:widget),
               builder: (context,snapshot){
                 if (snapshot.connectionState == ConnectionState.done) {
                   return CustomScrollView(
                       scrollDirection: Axis.vertical,
                       dragStartBehavior:DragStartBehavior.start ,
                       physics: BouncingScrollPhysics(),
                       slivers: [
                         SliverAppBar(
                             automaticallyImplyLeading: false,
                             leading: IconButton(
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                                 icon: Icon(FontAwesomeIcons.circleArrowLeft),
                                 iconSize: 28,
                                 color: Colors.white),
                             actions: [
                               IconButton(
                                   onPressed: () {
                                     Navigator.pushAndRemoveUntil(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) => Home_screen()),
                                             (route) => false);
                                   },
                                   icon: Icon(FontAwesomeIcons.houseUser),
                                   iconSize: 25,
                                   color: Colors.white)
                             ],
                             backgroundColor: Color.fromRGBO(123, 18, 18, 0.5),
                             centerTitle: false,
                             pinned: true,
                             expandedHeight:
                             MediaQuery.of(context).size.height * 0.4,
                             flexibleSpace: FlexibleSpaceBar(
                               collapseMode: CollapseMode.parallax,
                               background: FittedBox(
                                 fit: BoxFit.cover,
                                 child: cubit.MovieTrailer.isNotEmpty
                                     ? trailerwatch(cubit.MovieTrailer[0]['key'])
                                     : CircularProgressIndicator(color: Colors.black26,),
                               ),
                             )),
                         SliverList(
                             delegate: SliverChildListDelegate([
                               Column(
                                 children: [
                                   Row(children: [
                                     Container(
                                         padding: EdgeInsets.only(left: 10, top: 10),
                                         height: 50,
                                         width: MediaQuery.of(context).size.width,
                                         child: ListView.builder(
                                             padding: EdgeInsets.zero,
                                             physics: BouncingScrollPhysics(),
                                             scrollDirection: Axis.horizontal,
                                             itemCount: cubit.Moviesgeners.length,
                                             itemBuilder: (context, index) {
                                               //generes box
                                               return Container(
                                                   margin: EdgeInsets.only(right: 10),
                                                   padding: EdgeInsets.all(10),
                                                   decoration: BoxDecoration(
                                                       color:
                                                       Colors.white70,
                                                       borderRadius:
                                                       BorderRadius.circular(10)),
                                                   child: Text('${cubit.Moviesgeners[index]}'));
                                             })),
                                   ]),
                                   Row(
                                     children: [
                                       Container(
                                           padding: EdgeInsets.all(10),
                                           margin: EdgeInsets.only(left: 10, top: 10),
                                           height: 40,
                                           decoration: BoxDecoration(
                                               color: Colors.white70,
                                               borderRadius: BorderRadius.circular(10)),
                                           child: Text(
                                               '${cubit.Moviedetails[0]['runtime']} min'))
                                     ],
                                   )
                                 ],
                               ),
                               Padding(
                                   padding: EdgeInsets.only(left: 20, top: 10),
                                   child: Text('Movie Story:',style:TextStyle(color:Colors.white70))),
                               Padding(
                                   padding: EdgeInsets.only(left: 20, top: 10),
                                   child: Text(cubit.Moviedetails[0]['overview'].toString(),style:TextStyle(color:Colors.white70),)

                               ),

                               Padding(
                                 padding: EdgeInsets.only(left: 20, top: 10),
                                 child: UserReview(cubit.UserReviews),
                               ),
                               Padding(
                                   padding: EdgeInsets.only(left: 20, top: 20),
                                   child: Text('Release Date :${cubit.Moviedetails[0]['release_date']}',style:TextStyle(color:Colors.white70))),
                               Padding(
                                   padding: EdgeInsets.only(left: 20, top: 20),
                                   child: Text('Budget :${cubit.Moviedetails[0]['budget']}',style:TextStyle(color:Colors.white70))),
                               Padding(
                                   padding: EdgeInsets.only(left: 20, top: 20),
                                   child: Text('Revenue :${cubit.Moviedetails[0]['revenue']}',style:TextStyle(color:Colors.white70))),

                               slider_list(cubit.similarMovieList, "Similar Movies", "movie",
                                   cubit.similarMovieList.length),
                               slider_list(cubit.recomendedMovieList, "Recommended Movies",
                                   "movie", cubit.recomendedMovieList.length),
                               // Container(
                               //     height: 50,
                               //     child: Center(child: normaltext("By Niranjan Dahal")))
                             ])



                         )
                       ]);
                 } else {
                   return Center(
                       child: CircularProgressIndicator(
                         color: Colors.amber,
                       ));
                 }

               }),


 */