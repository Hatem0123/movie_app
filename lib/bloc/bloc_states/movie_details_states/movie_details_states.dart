abstract class Movie_details_states{}

class Movie_details_init_state extends Movie_details_states{}
class Movie_details_loading_state extends Movie_details_states{}
class Movie_details_sucess_state extends Movie_details_states{

}
class Movie_details_error_state extends Movie_details_states{

  final String? err;
  Movie_details_error_state(this.err);


}
///trailer ui screen state
class Trailer_UI_loading_state extends Movie_details_states{}
class Trailer_UI_get_sucess_state extends Movie_details_states{}
class Trailer_UI_get_error_state extends Movie_details_states{

  final String? err;
  Trailer_UI_get_error_state(this.err);


}

/// Movie Details(geners Screen screen state
class Geners_Movie_details_loading_state extends Movie_details_states{}
class Geners_Movie_details_sucess_state extends Movie_details_states{}
class Geners_Movie_details_error_state extends Movie_details_states{

  final String? err;
  Geners_Movie_details_error_state(this.err);


}


///User reviewes screen state

class User_Review_Search_loading_state extends Movie_details_states{}
class User_Review_get_Search_sucess_state extends Movie_details_states{}
class User_Review_get_Search_error_state extends Movie_details_states {

  final String? err;

  User_Review_get_Search_error_state(this.err);

}


/// Movie Details(Simliar Screen screen state
class Similar_Movie_details_loading_state extends Movie_details_states{}
class Similar_Movie_details_sucess_state extends Movie_details_states{}
class Similar_Movie_details_error_state extends Movie_details_states{

  final String? err;
  Similar_Movie_details_error_state(this.err);


}

/// Movie Details(recomended Screen screen state
class Recomended_Movie_details_loading_state extends Movie_details_states{}
class Recomended_Movie_details_sucess_state extends Movie_details_states{}
class Recomended_Movie_details_error_state extends Movie_details_states{

  final String? err;
  Recomended_Movie_details_error_state(this.err);


}









