import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app1/bloc/bloc_observer/bloc_observ.dart';
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'package:movie_app1/details/movies_detail/movie_details.dart';

import 'modules/home_screen/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 // Movies_details.init_movie_details_response();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>App_cubit(),
      child:

      BlocConsumer<App_cubit,App_states>(
        listener: (context,state){},
        builder: (context,state)=> MaterialApp(
          debugShowCheckedModeBanner: false,

          darkTheme:ThemeData(scaffoldBackgroundColor:Colors.black),
          themeMode: ThemeMode.dark,

          home: Home_screen(),
        ),

      ),
    );
  }
}

