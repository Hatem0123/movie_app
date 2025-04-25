import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app1/details/movies_detail/movie_details.dart';
import 'package:movie_app1/network/api_key/api_key.dart';
import 'dart:convert';

import 'package:movie_app1/network/http/http_helper.dart';


class App_cubit extends Cubit<App_states>{

 App_cubit(): super(App_init_state());


 static App_cubit get(context)=>BlocProvider.of(context);




///                  tab view screens
 ///tv_series
 List<Map<String,dynamic>> poular_tv_series=[];
 List<Map<String,dynamic>> OnAir_tv_series=[];
 List<Map<String,dynamic>> topRated_tv_series=[];



 Future<dynamic> fetchTvSeries_tab_view_screen() async {
  //popular_logic
  emit(Tv_series_Tab_view_poular_loading_state());
  try {
   var poular_response = await http.get(Uri.parse(poular_url));

   if (poular_response.statusCode == 200) {
    var temp_data = jsonDecode(poular_response.body);
    List popu_tv = temp_data['results'];
    for (var i = 0; i < popu_tv.length; i++) {
     poular_tv_series.add({
      'name': popu_tv[i]['name'],
      'poster_path': popu_tv[i]['poster_path'],
      'vote_average': popu_tv[i]['vote_average'],
      'Date': popu_tv[i]['first_air_date'],
      'id': popu_tv[i]['id'],

     });
    }
   emit(Tv_series_Tab_view_get_poular_sucess_state());
   } else {
    emit(Tv_series_Tab_view_get_poular_error_state('Failed to load popular TV series'));
   }
  } catch (e) {
   emit(Tv_series_Tab_view_get_poular_error_state(e.toString()));
  }


  //on_air_logic
  emit(Tv_series_on_air_Tab_view_poular_loading_state());
  try {
   var onAirTv_response = await http.get(Uri.parse(OnAir_url));

   if (onAirTv_response.statusCode == 200) {
    var temp_data = jsonDecode(onAirTv_response.body);
    List popu_tv = temp_data['results'];
    for (var i = 0; i < popu_tv.length; i++) {
     OnAir_tv_series.add({
      'name': popu_tv[i]['name'],
      'poster_path': popu_tv[i]['poster_path'],
      'vote_average': popu_tv[i]['vote_average'],
      'Date': popu_tv[i]['first_air_date'],
      'id': popu_tv[i]['id'],

     });
    }
    emit(Tv_series_on_air_Tab_view_get_poular_sucess_state());
   } else {
    emit(Tv_series_on_air_Tab_view_get_poular_error_state('Failed to load on air TV series'));
   }
  } catch (e) {
   emit(Tv_series_on_air_Tab_view_get_poular_error_state(e.toString()));
  }

  //Top_rated_logic
  emit(Tv_series_Top_ratedTab_view_poular_loading_state());
  try {
   var top_rated_response = await http.get(Uri.parse(topRated_url));

   if (top_rated_response.statusCode == 200) {
    var temp_data = jsonDecode(top_rated_response.body);
    List popu_tv = temp_data['results'];
    for (var i = 0; i < popu_tv.length; i++) {
     topRated_tv_series.add({
      'name': popu_tv[i]['name'],
      'poster_path': popu_tv[i]['poster_path'],
      'vote_average': popu_tv[i]['vote_average'],
      'Date': popu_tv[i]['first_air_date'],
      'id': popu_tv[i]['id'],

     });
    }
    emit(Tv_series_on_air_Tab_view_get_poular_sucess_state());
   } else {
    emit(Tv_series_Top_ratedTab_view_get_poular_error_state('Failed to load top rated TV series'));
   }
  } catch (e) {
   emit(Tv_series_Top_ratedTab_view_get_poular_error_state(e.toString()));
  }





 }


 ///movies

 List<Map<String,dynamic>> poular_MOVIES=[];
 List<Map<String,dynamic>> TOP_RATED_MOVIES=[];
 List<Map<String,dynamic>> NOW_PLAING_MOVIES=[];


 String popular_Movies_URL =
     'https://api.themoviedb.org/3/movie/popular?&api_key=$api_key';

 String Now_playing_Movies_URL =
     'https://api.themoviedb.org/3/movie/now_playing?&api_key=$api_key';

 String Top_rated_Movies_URL=
     'https://api.themoviedb.org/3/movie/top_rated?&api_key=$api_key';


 Future<void> Movies_list()async{
  //Future.delayed(Duration(seconds: 5));
  ///Popular logic
  try {
   http.get(Uri.parse(popular_Movies_URL)).then((value) async {
    emit(Movie_Tab_view_poular_loading_state());
    //var poular_Movies = await http.get(Uri.parse(popular_Movies_URL));

    if (value.statusCode == 200) {
     var temp_data = await jsonDecode(value.body);
     List popu_tv = temp_data['results'];

     for (var i = 0; i < popu_tv.length; i++) {
      poular_MOVIES.add({
       'name': popu_tv[i]['name'],
       'poster_path': popu_tv[i]['poster_path'],
       'vote_average': popu_tv[i]['vote_average'],
       'Date': popu_tv[i]['release_date'],
       'id': popu_tv[i]['id'],

      });
     }
     emit(Movie_Tab_view_poular_sucess_state());
    } else {
     print(value.statusCode);
    }
   }).catchError((err) {
    print(err.toString());
    emit(Movie_Tab_viewpoular_error_state(err.toString()));
   });
  }catch(e){
   emit(Movie_Tab_viewpoular_error_state(e.toString()));
  }
  ///Top Rated logic
  try {
   http.get(Uri.parse(Top_rated_Movies_URL)).then((value) async {
    emit(Movie_Tab_view_Top_Rated_loading_state());
    //var TOP_RATED_MOVIES_response = await http.get(Uri.parse(Top_rated_Movies_URL));

    if (value.statusCode == 200) {
     var temp_data = await jsonDecode(value.body);
     List popu_tv = temp_data['results'];

     for (var i = 0; i < popu_tv.length; i++) {
      TOP_RATED_MOVIES.add({
       'name': popu_tv[i]['name'],
       'poster_path': popu_tv[i]['poster_path'],
       'vote_average': popu_tv[i]['vote_average'],
       'Date': popu_tv[i]['release_date'],
       'id': popu_tv[i]['id'],

      });
     }
     emit(Movie_Tab_view_Top_Rated_sucess_state());
    }

    else {
     print(value.statusCode);
    }
   }).catchError((err) {
    print(err.toString());
    emit(Movie_Tab_Top_Rated_error_state(err.toString()));
   });
  }
  catch(err){
   emit(Movie_Tab_Top_Rated_error_state(err.toString()));
  }


  ///NowPlaying Logic

  try {
   http.get(Uri.parse(Now_playing_Movies_URL)).then((value) async {
    emit(Movie_Tab_view_Now_playing_loading_state());
    //var NowPlaying_response = await http.get(Uri.parse(Now_playing_Movies_URL));

    if (value.statusCode == 200) {
     var temp_data = await jsonDecode(value.body);
     List popu_tv = temp_data['results'];

     for (var i = 0; i < popu_tv.length; i++) {
      NOW_PLAING_MOVIES.add({
       'name': popu_tv[i]['name'],
       'poster_path': popu_tv[i]['poster_path'],
       'vote_average': popu_tv[i]['vote_average'],
       'Date': popu_tv[i]['release_date'],
       'id': popu_tv[i]['id'],

      });
     }
     emit(Movie_Tab_view_Now_playing_sucess_state());
    } else {
     print(value.statusCode);
    }
   }).catchError((err) {
    print(err.toString());
    emit(Movie_Tab_Now_playing_error_state(err.toString()));
   });
  }catch(err){
   emit(Movie_Tab_Now_playing_error_state(err.toString()));
  }











 }


 Future<void> fetchMovies() async {
  //emit(Tab_view_nav_state());

   await Movies_list(); // Assuming this fetches movies and updates lists


 }














///###############################################################################################

 ///                  Movie Details

 List<Map<String, dynamic>> Moviedetails = [];
 List<Map<String, dynamic>> UserReviews = [];
 List<Map<String, dynamic>> similarMovieList = [];
 List<Map<String, dynamic>> recomendedMovieList = [];
 List<Map<String, dynamic>> MovieTrailer = [];

 List<dynamic> Moviesgeners = [];
 //List<Map<String, dynamic>> movietrailerslist = [];


 // static init_movie_details_response(){
 //
 //  var gh =http.get(Uri.parse('https://api.themoviedb.org/3/movie/'));
 //
 // }

 Future<void> MovieDetails({
  // var Movies_Detail_URL,
  // var User_review_URL,
  // var Simliar_movie_URL,
  // var Recomended_movie_URL,
  // var Movie_trailer_URL,
 var sad})
 async {
  var Movies_Detail_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}?api_key=$api_key';

  var User_review_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/reviews?api_key=$api_key';
  var Simliar_movie_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/similar?api_key=$api_key';

  var Recomended_movie_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/recommendations?api_key=$api_key';


  var Movie_trailer_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/videos?api_key=$api_key';


http.get(Uri.parse(Movies_Detail_URL)).then((value)async{
emit(Movie_details_loading_state());
 if (value.statusCode == 200) {

  final movieDetailJson = await jsonDecode(value.body);
  for (var i = 0; i < 1; i++) {
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

  }
  for (var i = 0; i < movieDetailJson['genres'].length; i++) {
   Moviesgeners.add(movieDetailJson['genres'][i]['name']);
  }

  emit(Movie_details_sucess_state());

 } else {

 }


}).catchError((err){
print(err.toString());
emit(Movie_details_error_state(err));
});


http.get(Uri.parse(User_review_URL)).then((value)async{
 emit(user_reviewMovie_details_loading_state());
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
  emit(user_reviewMovie_details_sucess_state());
 }


}).catchError((err){
 print(err.toString());
 emit(user_reviewMovie_details_error_state(err));
});

http.get(Uri.parse(Movie_trailer_URL)).then((value)async{
 emit(Trailers_Movie_details_loading_state());



 print("📹 Trailers Status: ${value.statusCode}");

 if (value.statusCode == 200) {
  var trailerData =await jsonDecode(value.body);
  MovieTrailer = (trailerData['results'] as List?)
      ?.where((video) => video['type'] == "Trailer")
      .map((video) => {"key": video['key']})
      .toList() ?? [];
  print("✅ Trailers Details: ${MovieTrailer.toString()}");
 }
 emit(Trailers_Movie_details_sucess_state());

}).catchError((err){
 print(err.toString());
 emit(Trailers_Movie_details_error_state(err.toString()));
});

http.get(Uri.parse(Simliar_movie_URL)).then((value)async{
 emit(Similar_Movie_details_loading_state());
 if (value.statusCode == 200) {
  var similarmoviesjson = await jsonDecode(value.body);
  for (var i = 0; i < similarmoviesjson['results'].length; i++) {
   similarMovieList.add({
    "poster_path": similarmoviesjson['results'][i]['poster_path'],
    "name": similarmoviesjson['results'][i]['title'],
    "vote_average": similarmoviesjson['results'][i]['vote_average'],
    "Date": similarmoviesjson['results'][i]['release_date'],
    "id": similarmoviesjson['results'][i]['id'],
   });
  }
  emit(Similar_Movie_details_sucess_state());
 } else {}


}).catchError((err){
 print(err.toString());
 emit(Similar_Movie_details_error_state(err.toString()));
});


http.get(Uri.parse(Recomended_movie_URL)).then((value)async{
 emit(Recomended_Movie_details_loading_state());
 if (value.statusCode == 200) {
  var recommendedmoviesjson = await jsonDecode(value.body);
  for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
   recomendedMovieList.add({
    "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
    "name": recommendedmoviesjson['results'][i]['title'],
    "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
    "Date": recommendedmoviesjson['results'][i]['release_date'],
    "id": recommendedmoviesjson['results'][i]['id'],
   });
  }
  emit(Recomended_Movie_details_sucess_state());
 }
 else {}


}).catchError((err){

 print(err.toString());
 emit(Recomended_Movie_details_error_state(err.toString()));
});






  print("✅ Finished fetching all data.");



 }


 Future<void> fetchMovies_details() async {
  //emit(Tab_view_nav_state());

  await MovieDetails(); // Assuming this fetches movies and updates lists


 }

///User review screen state
 bool showall = false;

 Toggle_show_all(bool trig){

  trig = !showall;

}

}
///28 / 3
/*
 Future<void> MovieDetails({
  // var Movies_Detail_URL,
  // var User_review_URL,
  // var Simliar_movie_URL,
  // var Recomended_movie_URL,
  // var Movie_trailer_URL,
 var sad})
 async {
  var Movies_Detail_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}?api_key=$api_key';

  var User_review_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/reviews?api_key=$api_key';
  var Simliar_movie_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/similar?api_key=$api_key';

  var Recomended_movie_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/recommendations?api_key=$api_key';


  var Movie_trailer_URL =
      'https://api.themoviedb.org/3/movie/${sad
      .movie_id}/videos?api_key=$api_key';

  //emit(Movie_details_loading_state()); // Show loading state
  var movieDetailResponse = await http.get(Uri.parse(Movies_Detail_URL)).then((value){


  });
  var reviewsResponse = await http.get(Uri.parse(User_review_URL));
  var trailerResponse = await http.get(Uri.parse(Movie_trailer_URL));
  var similarmoviesresponse = await http.get(Uri.parse(Simliar_movie_URL));
  var recommendedmoviesresponse = await http.get(Uri.parse(Recomended_movie_URL));

   if (movieDetailResponse.statusCode == 200) {
    final movieDetailJson = jsonDecode(movieDetailResponse.body);
    // ✅ Clear previous data before adding new data

    for (var i = 0; i < 1; i++) {
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
    }

    // ✅ Debugging: Print the details to ensure they exist
    for (var i = 0; i < movieDetailJson['genres'].length; i++) {
     Moviesgeners.add(movieDetailJson['genres'][i]['name']);
    }
    // 🔥 Emit success state
   } else {

   }

   // ✅ Fetch User Reviews

   print("📝 User Reviews Status: ${reviewsResponse.statusCode}");

   if (reviewsResponse.statusCode == 200) {
    var reviewsData = await jsonDecode(reviewsResponse.body);
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
    emit(user_reviewMovie_details_sucess_state());
   }


   // ✅ Fetch Trailers



   print("📹 Trailers Status: ${trailerResponse.statusCode}");

   if (trailerResponse.statusCode == 200) {
    var trailerData =await jsonDecode(trailerResponse.body);
    MovieTrailer = (trailerData['results'] as List?)
        ?.where((video) => video['type'] == "Trailer")
        .map((video) => {"key": video['key']})
        .toList() ?? [];
    print("✅ Trailers Details: ${MovieTrailer.toString()}");
   }




  print("✅ Finished fetching all data.");






  /////////////////////////////similar movies
  //try {


   if (similarmoviesresponse.statusCode == 200) {
    var similarmoviesjson = await jsonDecode(similarmoviesresponse.body);
    for (var i = 0; i < similarmoviesjson['results'].length; i++) {
     similarMovieList.add({
      "poster_path": similarmoviesjson['results'][i]['poster_path'],
      "name": similarmoviesjson['results'][i]['title'],
      "vote_average": similarmoviesjson['results'][i]['vote_average'],
      "Date": similarmoviesjson['results'][i]['release_date'],
      "id": similarmoviesjson['results'][i]['id'],
     });
    }

   } else {}



   if (recommendedmoviesresponse.statusCode == 200) {
    var recommendedmoviesjson = await jsonDecode(
        recommendedmoviesresponse.body);
    for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
     recomendedMovieList.add({
      "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
      "name": recommendedmoviesjson['results'][i]['title'],
      "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
      "Date": recommendedmoviesjson['results'][i]['release_date'],
      "id": recommendedmoviesjson['results'][i]['id'],
     });
    }

   }
   else {}








 }

 */

/*

 var moviedetailresponse = await http.get(Uri.parse(Movies_Detail_URL));
   if (moviedetailresponse.statusCode == 200) {
    print("📝 Movie details Status: ${moviedetailresponse.statusCode}");
    var moviedetailjson = await jsonDecode(moviedetailresponse.body);
    for (var i = 0; i < 1; i++) {
     Moviedetails.add({
      "backdrop_path": moviedetailjson['backdrop_path'],
      "title": moviedetailjson['title'],
      "vote_average": moviedetailjson['vote_average'],
      "overview": moviedetailjson['overview'],
      "release_date": moviedetailjson['release_date'],
      "runtime": moviedetailjson['runtime'],
      "budget": moviedetailjson['budget'],
      "revenue": moviedetailjson['revenue'],
     });
    }
    for (var i = 0; i < moviedetailjson['genres'].length; i++) {
     Moviesgeners.add(moviedetailjson['genres'][i]['name']);
    }
    emit(Movie_details_sucess_state());
   }
  }catch(err){

    print(err.toString());
    emit(Movie_details_error_state(err.toString()));
  }

   try {
   emit(user_reviewMovie_details_loading_state());
    // ✅ Fetch User Reviews
    var reviewsResponse = await http.get(Uri.parse(User_review_URL));
    print("📝 User Reviews Status: ${reviewsResponse.statusCode}");

    if (reviewsResponse.statusCode == 200) {
     var reviewsData = await jsonDecode(reviewsResponse.body);
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
     emit(user_reviewMovie_details_sucess_state());
    }
   }
   catch (err) {
    emit(user_reviewMovie_details_error_state(err.toString()));
   }

    try{
    // ✅ Fetch Trailers
     emit(Trailers_Movie_details_loading_state());
    var trailerResponse = await http.get(Uri.parse(Movie_trailer_URL));
    print("📹 Trailers Status: ${trailerResponse.statusCode}");

    if (trailerResponse.statusCode == 200) {
     var trailerData = await jsonDecode(trailerResponse.body);
     MovieTrailer = (trailerData['results'] as List?)
         ?.where((video) => video['type'] == "Trailer")
         .map((video) => {"key": video['key']})
         .toList() ?? [];
     emit(Trailers_Movie_details_sucess_state());
    }
   }
   catch (e) {
   print("🚨 Exception: $e");
   emit(Trailers_Movie_details_error_state(e.toString()));
  }

  print("✅ Finished fetching all data.");



  // print(movietrailerslist);



  /////////////////////////////similar movies
  try {
   emit(Similar_Movie_details_loading_state());
   var similarmoviesresponse = await http.get(Uri.parse(Simliar_movie_URL));
   if (similarmoviesresponse.statusCode == 200) {
    var similarmoviesjson = await jsonDecode(similarmoviesresponse.body);
    for (var i = 0; i < similarmoviesjson['results'].length; i++) {
     similarMovieList.add({
      "poster_path": similarmoviesjson['results'][i]['poster_path'],
      "name": similarmoviesjson['results'][i]['title'],
      "vote_average": similarmoviesjson['results'][i]['vote_average'],
      "Date": similarmoviesjson['results'][i]['release_date'],
      "id": similarmoviesjson['results'][i]['id'],
     });
    }
    emit(Similar_Movie_details_sucess_state());
   } else {}
  }catch(ee){
   emit(Similar_Movie_details_error_state(ee.toString()));
  }
  // print(similarmovieslist);
  /////////////////////////////recommended movies
  try {
   emit(Recomended_Movie_details_loading_state());
   var recommendedmoviesresponse =
   await http.get(Uri.parse(Recomended_movie_URL));
   if (recommendedmoviesresponse.statusCode == 200) {
    var recommendedmoviesjson = await jsonDecode(
        recommendedmoviesresponse.body);
    for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
     recomendedMovieList.add({
      "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
      "name": recommendedmoviesjson['results'][i]['title'],
      "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
      "Date": recommendedmoviesjson['results'][i]['release_date'],
      "id": recommendedmoviesjson['results'][i]['id'],
     });
    }
    emit(Recomended_Movie_details_sucess_state());
   }
   else {}
  }
  catch(ee){
   emit(Recomended_Movie_details_error_state(ee.toString()));

  }
  // print(recommendedmovieslist);


 */


// List<BottomNavigationBarItem> bottomItems=[
 //  BottomNavigationBarItem(icon:Icon(Icons.business),label:'Business'),
 //  BottomNavigationBarItem(icon:Icon(Icons.sports),label:'Sports'),
 //  BottomNavigationBarItem(icon:Icon(Icons.science),label:'Science'),
 //  BottomNavigationBarItem(icon:Icon(Icons.settings),label:'Settings'),
 //
 //
 // ];
 //


 // int current_index =0;

 //List<Widget> screens =[Busniess_screen(),Sports_screen(),Science_screen(),Settings_screen()];

 // List<dynamic> busniess =[];
 // List<dynamic> sports =[];
 // List<dynamic> science =[];
 //

//  void Change_bottom_nav_bar(int index){
//
//   current_index = index;
//   ///calling the data when i press on the specific bottom item
// // if(index == 0 && index == 0){
// //   get_sports();
// //   get_science();
// // }
//
//
//
//
//
//   emit(News_bottom_nav_state());
//
//  }
//
//  void get_busness(){
//   emit(News_bottom_loading_state());
//   Dio_helper.get_data_from_api(url:'v2/top-headlines',
//       query: {
//        'country':'us',
//        'category':'business',
//        'apiKey':'05990b2b657945a3811a7e82543c5421',
//       }).then((value){
//    print(value.data.toString());
//    busniess =value.data['articles'];
//
//    emit(News_get_busniess_sucess_state());
//   }).catchError((err){
//    print(err);
//
//    emit(News_get_busniess_error_state(err.toString()));
//
//   });
//  }
//  void get_sports(){
//   emit(News_sports_loading_state());
//
//
//   Dio_helper.get_data_from_api(url:'v2/top-headlines',
//       query: {
//        'country':'us',
//        'category':'sports',
//        'apiKey':'05990b2b657945a3811a7e82543c5421',
//       }).then((value){
//    sports = value.data['articles'];
//    emit(News_get_sports_sucess_state());
//   }).catchError((err){
//    print(err);
//    emit(News_get_sports_error_state(err.toString()));
//
//   });
//
//  }
//  void get_science(){
//   emit(News_Science_loading_state());
//
//   Dio_helper.get_data_from_api(url:'v2/top-headlines',
//       query: {
//
//        'country':'us',
//        'category':'science',
//        'apiKey':'05990b2b657945a3811a7e82543c5421',
//
//       }).then((value){
//    print(value.data.toString());
//    science =value.data['articles'];
//    print("################################################################################################################");
//    print(busniess[3]['titles']);
//    emit(News_get_Science_sucess_state());
//   }).catchError((err){
//    print(err);
//    emit(News_get_Science_error_state(err.toString()));
//   });
//
//
//
//
//
//
//
//  }
//
//  ThemeMode themeMode =ThemeMode.dark;
//  bool Isdark =false;
//
//  void Change_app_them_dark(){
//
//   Isdark = !Isdark;
//
//   emit(app_theme_state());
//
//  }
//





 //
 //
 // List<dynamic> search=[];
 //
 // void get_search(dynamic value){
 //  emit(News_Search_loading_state());
 //
 //  search = [];
 //
 //  Dio_helper.get_data_from_api(url:'v2/top-headlines',
 //      query: {
 //
 //
 //       'q':'$value',
 //       'apiKey':'05990b2b657945a3811a7e82543c5421',
 //
 //      }).then((value){
 //   print(value.data.toString());
 //   search =value.data['articles'];
 //
 //   emit(News_get_Search_sucess_state());
 //  }).catchError((err){
 //   print(err);
 //   emit(News_get_Search_error_state(err.toString()));
 //  });
 //
 //
 //
 //
 //
 //
 //
 // }
 //
 // static void get_permission(){
 //  PermissionRequestScreen();
 // }
 //





