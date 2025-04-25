
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'package:movie_app1/details/Tv_series_detail/Tv_series_details.dart';
import 'package:movie_app1/details/movies_detail/movie_details.dart';
import 'package:movie_app1/modules/home_screen/home.dart';
import 'package:movie_app1/modules/trailer_ui/trailer_ui.dart';
import 'package:movie_app1/modules/user_review/user_review.dart';
import 'package:movie_app1/network/api_key/api_key.dart';
import 'package:http/http.dart' as http;


///the tap view slider list
Widget slider_list(List firstListName,String CategoryTitle,String Type,int ItemCount)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Padding(
      padding: const EdgeInsets.only(left: 10.0,top: 15.0,bottom: 40.0),
      child: Text(CategoryTitle.toString(),style: TextStyle(color: Colors.white),),
    ),
    Container(
      height: 250,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount:ItemCount
          ,
          itemBuilder:(context,index){

            return GestureDetector(
              onTap: (){
                print(firstListName);
                if(Type =='movie'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Movies_details(movie_id: firstListName[index]['id'],)));
                }
                else if(Type =='tv'){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Tv_series_details(tv_id: firstListName[index]['id'],)));
                }



              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MoviesDetails()));


              },
              child: Container(
                width: 170,
                child:Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(
                      top: 2,left: 6,
                    ),
                      child: Text(firstListName[index]['Date'],style:TextStyle(color: Colors.white),),

                    ),
                    Padding(padding: EdgeInsets.only(
                        top: 2,right: 6
                    ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white10.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Padding(padding: EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                            left: 5,
                            right: 5

                        ),
                          child: Row(
                            children: [
                              Icon(Icons.star,color:Colors.amber,),
                              Text(firstListName[index]['vote_average'].toString())],
                          ),


                        ),
                      ),
                    )

                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3),
                            BlendMode.darken),

                        fit:BoxFit.cover,image:NetworkImage('https://image.tmdb.org/t/p/w500${firstListName[index]['poster_path']}') )
                ),
                margin: EdgeInsets.only(left: 13),

              ),

            );


          } ),
    )
  ],

);
















Widget details_secreneto({ List? deatils_list_name,
  List<dynamic>? genersListName,
  List<Map<String, dynamic>>? trailerListName,
  List<Map<String, dynamic>>? user_reviews_ListName,
  List<Map<String, dynamic>>? similar_ListName,
  List<Map<String, dynamic>>? recomende_ListName,
  Future<Object?>? method_name,
  BuildContext? context
}) {


  return

    FutureBuilder(
        future:method_name,
        builder: (context, snapshot) {
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
                          child: trailerListName!.isNotEmpty
                              ? trailerwatch(trailerListName[0]['key'])
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
                                      itemCount: genersListName!.length,
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
                                            child: Text('${genersListName[index]}'));
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
                                        '${deatils_list_name![0]['runtime']} min'))
                              ],
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text('Movie Story :',style:TextStyle(color:Colors.white70))),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text('${deatils_list_name![0]['overview'].toString()}',style:TextStyle(color:Colors.white70),)

                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: UserReview(user_reviews_ListName!),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text('Release Date : ${deatils_list_name[0]['release_date']}',style:TextStyle(color:Colors.white70))),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text('Budget : ${deatils_list_name[0]['budget']}',style:TextStyle(color:Colors.white70))),
                        Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text('Revenue : ${deatils_list_name[0]['revenue']}',style:TextStyle(color:Colors.white70))),

                        slider_list(similar_ListName!, "Similar Movies", "movie",
                            similar_ListName.length),
                        slider_list(recomende_ListName!, "Recommended Movies",
                            "movie", recomende_ListName.length),
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
        });


}



/*
         // SliverAppBar(
                //   expandedHeight:MediaQuery.of(context).size.height * 0.3,
                //   floating: true,
                //   pinned: false,
                //   flexibleSpace: FlexibleSpaceBar(
                //     background: trailerwatch(trailerListName![0]['key']),
                //
                //   ),
                // ),

 */