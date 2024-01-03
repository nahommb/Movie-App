import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as https;

class youTubeVideo extends StatefulWidget {
   final String id;
  youTubeVideo({required this.id});

  @override
  State<youTubeVideo> createState() => _youTubeVideoState();
}

class _youTubeVideoState extends State<youTubeVideo> {

  //final vdurl = "https://www.youtube.com/watch?v=X7rkaPoLy8M";

late YoutubePlayerController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     //getvideo();
    _controller = YoutubePlayerController(
        initialVideoId: widget.id,
      flags:const YoutubePlayerFlags(
        autoPlay:false,
        mute: false,
        useHybridComposition: true
      )

   );


  }
  @override
  Widget build(BuildContext context) {

    return Container(

      child: YoutubePlayer(
        controller:_controller,
        showVideoProgressIndicator: true,

        // onReady: (){
        //   _controller.addListener(() {print("playing"); });
        // },

        bottomActions: [
          CurrentPosition(),
          RemainingDuration(),
          ProgressBar(
            isExpanded: true,

            colors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.grey
            ),
          ),
         PlaybackSpeedButton(),

        ],
      ),
    );
  }
}
