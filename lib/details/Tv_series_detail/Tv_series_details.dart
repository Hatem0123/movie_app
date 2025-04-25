import 'package:flutter/material.dart';

class Tv_series_details extends StatefulWidget {

  var tv_id;

  Tv_series_details({this.tv_id});

  @override
  State<Tv_series_details> createState() => _Tv_series_detailsState();
}

class _Tv_series_detailsState extends State<Tv_series_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
