import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'package:movie_app1/modules/tab_view_sectio/movies/movies.dart';
import 'package:movie_app1/modules/tab_view_sectio/tv_series/tv_series.dart';
import 'package:movie_app1/modules/tab_view_sectio/upcoming/upcoming.dart';

import '../../network/api_key/api_key.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> with TickerProviderStateMixin{










  var trendingLisTt =[];

  Future<void> trendingList()async{


if(uval ==1){

  var trendingWeekResponse =await http.get(Uri.parse(trendingWeekUrl));

  if(trendingWeekResponse.statusCode == 200){
    var tempdata =jsonDecode(trendingWeekResponse.body);
    List trending_week_json = tempdata['results'];

    for(var i =0; i <trending_week_json.length;i++){
      trendingLisTt.add({
        'id':trending_week_json[i]['id'],
        'poster_path':trending_week_json[i]['poster_path'],
        'vote_average':trending_week_json[i]['vote_average'],
        'media_type':trending_week_json[i]['media_type'],
        'indexno' : i
      });


    }

  }


}

else if(uval ==2 ){
  var trendingDayResponse = await http.get(Uri.parse(trendingDayUrl));

  if(trendingDayResponse.statusCode == 200){
    var tempdata =jsonDecode(trendingDayResponse.body);
    List trending_dday_json = tempdata['results'];

    for(var i =0; i <trending_dday_json.length;i++){
      trendingLisTt.add({
        'id':trending_dday_json[i]['id'],
        'poster_path':trending_dday_json[i]['poster_path'],
        'vote_average':trending_dday_json[i]['vote_average'],
        'media_type':trending_dday_json[i]['media_type'],
        'indexno' : i
      });


    }

  }


}









  }



int uval =1;
  @override
  Widget build(BuildContext context) {

    TabController _tabcont = TabController(length: 3, vsync: this);


    return BlocProvider(
       create:(context)=>App_cubit()..fetchTvSeries_tab_view_screen(),

      child:
        Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black12,
                centerTitle:true,
                pinned: true,
                toolbarHeight: 60,
                expandedHeight: MediaQuery.of(context).size.height *0.5,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: FutureBuilder(future:trendingList(), builder:(context,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return CarouselSlider(
                          items: trendingLisTt.map((i){

                            return Builder(builder: (context){

                              return GestureDetector(
                                onTap: (){},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.3),
                                        BlendMode.darken,
                                      ), image: NetworkImage('https://image.tmdb.org/t/p/w500${i['poster_path']}')

                                      )
                                  ),
                                ),
                              );

                            });
                          }).toList(),

                          options:CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 2),
                              height: MediaQuery.of(context).size.height
                          )
                      );

                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                  }),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Trending ",style:TextStyle(fontSize: 16,color:Colors.white),),
                    SizedBox(width: 10,),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(padding: const EdgeInsets.all(4.0),
                        child: DropdownButton(
                          dropdownColor: Colors.black.withOpacity(0.6),
                          autofocus: true,
                          underline: Container(height: 0,color: Colors.transparent,),


                          icon: Icon(Icons.arrow_drop_down_sharp,
                          color: Colors.deepOrange,
                            size: 30,
                          ),

                          items:[
                          DropdownMenuItem(child:
                          Text("Weekly",style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 16
                          ),

                          ),value:1,
                          ),
                          DropdownMenuItem(child:
                          Text("DaY",style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 16
                          ),),
                              value:2

                          ),


                        ],
                            onChanged: (value){

                                setState(() {
                                    trendingLisTt.clear();
                                  uval = int.parse(value.toString());

                                });

                            },
                          value: uval,




                            ),

                      ),
                    )

                  ],),
              ),

              SliverList(delegate:SliverChildListDelegate([

                Center(
                  child: Text("sample"),
                ),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                    physics: BouncingScrollPhysics(),
                      labelPadding: EdgeInsets.symmetric(horizontal: 25),
                      isScrollable: true,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepOrange.withOpacity(0.4)
                      ),
                      controller: _tabcont,
                      tabs: [

                        Tab(child: Text("Tv Series",style: TextStyle(color: Colors.white),),),
                        Tab(child: Text("Movies",style: TextStyle(color: Colors.white),),),
                        Tab(child: Text("UpComing",style: TextStyle(color: Colors.white),),),

                  ]),


                ),

                Container(

                  height: 1050,
                  child: TabBarView(
                      controller: _tabcont,

                      children: [
                    TvSeries(),
                        Movies(),
                        UpComing(),

                  ]),

                )

              ])

              )

            ],
          ),
        ),
      );
  }
}
