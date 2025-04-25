import 'package:flutter/material.dart';
import 'package:movie_app1/details/Tv_series_detail/Tv_series_details.dart';
import 'package:movie_app1/details/movies_detail/movie_details.dart';


class Description_chech_ui extends StatefulWidget {

  var new_id;
  var new_type;

  Description_chech_ui({this.new_id,this.new_type});
  @override
  State<Description_chech_ui> createState() => _Description_chech_uiState();
}

class _Description_chech_uiState extends State<Description_chech_ui> {

  Widget checktype(){

    if(widget.new_type=='movie'){

     return Movies_details(movie_id: widget.new_id,);
    }
    else if(widget.new_type=='tv'){

      return Tv_series_details(tv_id: widget.new_id,);
    }
    else{
      return  errorui();
    }



  }


  @override
  Widget build(BuildContext context) {
    return checktype();
  }

  Widget errorui() {

    return Scaffold(
      body: Center(

        child: Text("error"),
      ),

    );

  }
}
