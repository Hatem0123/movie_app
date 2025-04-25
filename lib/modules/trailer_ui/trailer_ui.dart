import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app1/bloc/bloc_states/bloc_state.dart';
import 'package:movie_app1/bloc/block_logic/block_logic.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
class trailerwatch extends StatefulWidget {
  var trailerytid;

  trailerwatch(this.trailerytid);

  @override
  State<trailerwatch> createState() => _trailerwatchState();
}

class _trailerwatchState extends State<trailerwatch> {

  late YoutubePlayerController _controller;
   bool Is_playing= false;


  void initState() {
    //final video_url ='https://img.youtube.com/vi/${widget.trailerytid}/hqdefault.jpg';
    super.initState();
    var videoid = YoutubePlayer.convertUrlToId(widget.trailerytid);
    _controller = YoutubePlayerController(
      initialVideoId: videoid.toString(),
      flags:const  YoutubePlayerFlags(
        enableCaption: true,
        autoPlay: false,
        mute: false,        // controlsVisibleAtStart: true,
        forceHD: false,


      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return
      Padding(
              padding: const EdgeInsets.all(0.0),
              child:

              YoutubePlayer(
      thumbnail: Image.network(
        "https://img.youtube.com/vi/${widget.trailerytid}/hqdefault.jpg",
        fit: BoxFit.cover,
      ),
      controlsTimeOut: Duration(milliseconds: 1500),
       aspectRatio: 16 / 9,
      controller: _controller,
      showVideoProgressIndicator: true,
      bufferIndicator: const Center(
        child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            )),
      ),
      progressIndicatorColor: Colors.amber,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: Colors.white,
              handleColor: Colors.amber,
            )),
        RemainingDuration(),
        FullScreenButton(),
      ],
             ),
         );


  }
}


class VideoHeader extends SliverPersistentHeaderDelegate {
  final String trailerYTId;

  VideoHeader(this.trailerYTId);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double opacity = 1.0 - (shrinkOffset / maxExtent); // Smooth fade-out

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        color: Colors.black,
        child: trailerwatch(trailerYTId), // ✅ Uses optimized controller
      ),
    );
  }

  @override
  double get maxExtent => 250.0;
  @override
  double get minExtent => 0.0;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

