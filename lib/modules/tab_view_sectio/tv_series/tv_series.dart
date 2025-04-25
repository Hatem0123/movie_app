import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'package:movie_app1/network/api_key/api_key.dart';
import 'package:movie_app1/shared/components/components.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {

  @override
  Widget build(BuildContext context) {
    var poular_tv_series = App_cubit.get(context).poular_tv_series;
    var OnAir_tv_series = App_cubit.get(context).OnAir_tv_series;
    var topRated_tv_series = App_cubit.get(context).topRated_tv_series;








    var fun =  App_cubit.get(context).fetchTvSeries_tab_view_screen();



    return
      
      BlocProvider(
        create: (context)=>App_cubit(),
        child: BlocConsumer<App_cubit,App_states>(

          listener:(context,state){} ,
          builder:(context,state)=>  FutureBuilder(future:fun,
              builder:(context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(color: Colors.deepOrange,),
                  );
                }else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      slider_list(poular_tv_series, 'Popular TV Series', "tv", 20),
                      slider_list(OnAir_tv_series, 'On The Air', "tv", 20),
                      slider_list(topRated_tv_series, 'Top Rated Series', "tv", 20),

                    ],

                  );
                }


              }),


        ),
      );
  }
}
