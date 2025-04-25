import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';

class UserReview extends StatefulWidget {
  List revdeatils;
  UserReview(this.revdeatils);
  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool showall = false;

  @override
  Widget build(BuildContext context) {
    // var ss = App_cubit.get(context).showall;
    // var show_fun = App_cubit.get(context).Toggle_show_all(ss);
    // var dd = App_cubit.get(context);
    List REviewDetails = widget.revdeatils;
    if (REviewDetails.length == 0) {
      return Center(child:Text("No reiviews"),);
    } else {
      return

        BlocConsumer<App_cubit,App_states>(
            listener: (context,state){},
            builder: (context,state)=> Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'User Reviews',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showall = !showall;
                        });
                      },
                      child: Row(
                        children: [
                          showall == false ? Text(
                            'All Reviews ' '${REviewDetails.length}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                              : Text(
                            'Show Less',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //
              //show only one review
              showall == true
                  ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: REviewDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage('${REviewDetails[index]['avatarphoto']}'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  '${REviewDetails[index]['name']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text('${ REviewDetails[index]
                                              ['creationdate']}'
                                               ,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              REviewDetails[index]['rating'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      REviewDetails[index]['review'],style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }))
                  : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    // Container(
                                    //   height: 50,
                                    //   width: 50,
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       image: DecorationImage(
                                    //           image: NetworkImage(REviewDetails[0]
                                    //           ['avatarphoto']),
                                    //           fit: BoxFit.cover)),
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            REviewDetails[0]['name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          REviewDetails[0]['creationdate'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        REviewDetails[0]['rating'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                REviewDetails[0]['review'],style: TextStyle(color: Colors.white70),
                              ),
                            )
                          ],
                        ),
                        //show more button
                      ],
                    ),
                  ))
            ],

          ),





        );



    }


  }
}
