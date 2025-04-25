abstract class App_states{}
class App_init_state extends App_states{}
class Tab_view_nav_state extends App_states{}

///home screen state
class Home_loading_state extends App_states{}
class Home_get_busniess_sucess_state extends App_states{}
class Home_get_busniess_error_state extends App_states{

  final String? err;
  Home_get_busniess_error_state(this.err);


}
/////////////TabView states
/// movie popular tab view screen state
class Movie_Tab_view_poular_loading_state extends App_states{}
class Movie_Tab_view_poular_sucess_state extends App_states{}
class Movie_Tab_viewpoular_error_state extends App_states{

  final String? err;
  Movie_Tab_viewpoular_error_state(this.err);


}
///Top rated
class Movie_Tab_view_Top_Rated_loading_state extends App_states{}
class Movie_Tab_view_Top_Rated_sucess_state extends App_states{}
class Movie_Tab_Top_Rated_error_state extends App_states{

  final String? err;
  Movie_Tab_Top_Rated_error_state(this.err);


}

///Now playing
class Movie_Tab_view_Now_playing_loading_state extends App_states{}
class Movie_Tab_view_Now_playing_sucess_state extends App_states{}
class Movie_Tab_Now_playing_error_state extends App_states{

  final String? err;
  Movie_Tab_Now_playing_error_state(this.err);


}
















/// tv_seriees Popular tab view screen state
class Tv_series_Tab_view_poular_loading_state extends App_states{}
class Tv_series_Tab_view_get_poular_sucess_state extends App_states{}
class Tv_series_Tab_view_get_poular_error_state extends App_states{

  final String? err;
  Tv_series_Tab_view_get_poular_error_state(this.err);


}


/// tv_seriees on_air tab view screen state
class Tv_series_on_air_Tab_view_poular_loading_state extends App_states{}
class Tv_series_on_air_Tab_view_get_poular_sucess_state extends App_states{}
class Tv_series_on_air_Tab_view_get_poular_error_state extends App_states{

  final String? err;
  Tv_series_on_air_Tab_view_get_poular_error_state(this.err);


}


/// tv_seriees top_rated tab view screen state
class Tv_series_Top_ratedTab_view_poular_loading_state extends App_states{}
class Tv_series_Top_ratedTab_view_get_poular_sucess_state extends App_states{}
class Tv_series_Top_ratedTab_view_get_poular_error_state extends App_states{

  final String? err;
  Tv_series_Top_ratedTab_view_get_poular_error_state(this.err);


}



///trailer ui screen state
class Trailer_UI_loading_state extends App_states{}
class Trailer_UI_get_sucess_state extends App_states{}
class Trailer_UI_get_error_state extends App_states{

  final String? err;
  Trailer_UI_get_error_state(this.err);


}

class app_theme_state extends App_states{}


///User reviewes screen state
class User_Review_Search_loading_state extends App_states{}
class User_Review_get_Search_sucess_state extends App_states{}
class User_Review_get_Search_error_state extends App_states {

  final String? err;

  User_Review_get_Search_error_state(this.err);

}





/// Movie Details Screen screen state
class Movie_details_loading_state extends App_states{}
class Movie_details_sucess_state extends App_states{}
class Movie_details_error_state extends App_states{

  final String? err;
  Movie_details_error_state(this.err);


}

/// Movie Details(USER Reviews  Screen screen state
class user_reviewMovie_details_loading_state extends App_states{}
class user_reviewMovie_details_sucess_state extends App_states{}
class user_reviewMovie_details_error_state extends App_states{

  final String? err;
  user_reviewMovie_details_error_state(this.err);


}

/// Movie Details(Trailers  Screen screen state
class Trailers_Movie_details_loading_state extends App_states{}
class Trailers_Movie_details_sucess_state extends App_states{}
class Trailers_Movie_details_error_state extends App_states{

  final String? err;
  Trailers_Movie_details_error_state(this.err);


}

/// Movie Details(Simliar Screen screen state
class Similar_Movie_details_loading_state extends App_states{}
class Similar_Movie_details_sucess_state extends App_states{}
class Similar_Movie_details_error_state extends App_states{

  final String? err;
  Similar_Movie_details_error_state(this.err);


}

/// Movie Details(recomended Screen screen state
class Recomended_Movie_details_loading_state extends App_states{}
class Recomended_Movie_details_sucess_state extends App_states{}
class Recomended_Movie_details_error_state extends App_states{

  final String? err;
  Recomended_Movie_details_error_state(this.err);


}







