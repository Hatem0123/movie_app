import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'dart:convert';
import 'package:movie_app1/network/api_key/api_key.dart';
import 'package:movie_app1/shared/components/components.dart';
class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _Movies();
}

class _Movies extends State<Movies> {

// @override
//   void initState() {
//     App_cubit.get(context).Movies_list();
//     super.initState();
//   }



  @override
  Widget build(BuildContext context) {
    var poular_MOVIES = App_cubit.get(context).poular_MOVIES;
    var TOP_RATED_MOVIES = App_cubit.get(context).TOP_RATED_MOVIES;
    var NOW_PLAING_MOVIES = App_cubit.get(context).NOW_PLAING_MOVIES;
    var fun =App_cubit.get(context).fetchMovies();

    return BlocProvider(
      create: (context) {

        return App_cubit()..fetchMovies();
      },

      child: BlocConsumer<App_cubit,App_states>(
        listener: (context,state){},
        builder: (context,state) {

          try{
            return

              Column(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  slider_list(poular_MOVIES, "Popular Movies", "movie", 20),
                  slider_list(NOW_PLAING_MOVIES, "Now Playing Movies", "movie", 20),
                  slider_list(TOP_RATED_MOVIES, "Top Rated Movies", "movie", 20),

                ],
              );
          }on RangeError{

            return Center(child: CircularProgressIndicator(color:Colors.deepOrange,));
          }




          //var fun = App_cubit.get(context).Movies_list();

          }


        ,
      ),
    );
  }
}
