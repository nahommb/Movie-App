
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/video.dart';
import 'package:http/http.dart' as https;

class movieData extends StatefulWidget {

  final String imagepath;
  final String overview;
  final String title;
  final String id;

  movieData({required this.imagepath,required this.overview,required this.title ,required this.id});

  @override
  State<movieData> createState() => _movieDataState();
}

class _movieDataState extends State<movieData> {


  // void getvideo() async{
  //   var url = Uri.parse("https://api.themoviedb.org/3/movie/${widget.id}?api_key=1828dc6fe548be842d9bafb3e0db06ea&append_to_response=videos");
  //   https.Response rs = await https.get(url);
  //   setState(() {
  //     final apibody = rs.body;
  //     final data = jsonDecode(apibody);
  //     moviekey = data["videos"]["results"][0]["key"];
  //     // print(moviekey);
  //     print(data["videos"]["results"][0]["type"]);
  //     for(var i=0;i<=data["videos"]["results"].length;i++){
  //       if("Trailer"== "${data['videos']['results'][i]['type']}"){
  //         print("yessss");
  //       }
  //     }
  //     // _controller = YoutubePlayerController(
  //     //     initialVideoId: moviekey,
  //     //     flags:const YoutubePlayerFlags(
  //     //         autoPlay:false,
  //     //         mute: false,
  //     //         useHybridComposition: true
  //     //     )
  //     //
  //     // );
  //   });
  //
  // }
  @override
  Widget build(BuildContext context) {

    final md =MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context,constraints){
        return  Card(

          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
           shadowColor: Colors.purpleAccent,
           elevation: 8,
          // ),
          child: Column(
            children: [
              Column(
                  children:[
                   widget.id==""? Container(
                     width: double.infinity,
                     child: Center(child: Text("No video Available"),),
                   ) :Padding(padding: EdgeInsets.only(left: 1,right: 1),
                       child: youTubeVideo(id:widget.id)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                            color: Colors.grey,
                          ),
                          height: md.size.height*0.3,
                          width: constraints.maxWidth*0.49,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              child:Image.network("https://image.tmdb.org/t/p/w200/${widget.imagepath}",fit: BoxFit.cover)
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth*0.01,),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                            // color: Colors.grey,
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(30),
                          //     bottomRight: Radius.circular(30),
                          //   ),
                          //   child:Image.network("https://image.tmdb.org/t/p/w400/${widget.overview}",fit: BoxFit.cover) ,
                          // ),
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Card(
                                        color: Color(0xFF7DCE13),

                                        child:  Padding( padding: EdgeInsets.all(8),
                                            child: Text("Title: ${widget.title}"))),
                                  ),
                                     Card(
                                       elevation: 10,
                                         color: Color(0xFF8E05C2),
                                       child: Padding( padding: EdgeInsets.all(10),
                                          child: Text("${widget.overview}" ,style: TextStyle(fontSize:12,color: Colors.white),)),
                                     )
                                ]),
                          ),
                          height: md.size.height*0.3,
                          width: constraints.maxWidth*0.47,

                        ),
                      ],
                    ),
                  ]
              )],
          ),
        );
      },
    );
  }
}


//
// class movieData extends StatelessWidget {
//
// final String imagepath;
// final String overview;
// final String title;
// final int id;
//
//   movieData({required this.imagepath,required this.overview,required this.title ,required this.id});
//
// String moviekey;
// Future getvideo() async{
//   var url = Uri.parse("https://api.themoviedb.org/3/movie/${id}?api_key=1828dc6fe548be842d9bafb3e0db06ea&append_to_response=videos");
//   https.Response rs = await https.get(url);
//   setState(() {
//     final apibody = rs.body;
//     final data = jsonDecode(apibody);
//     moviekey =data["videos"]["results"][0]["key"];
//     // print(moviekey);
//     print(data["videos"]["results"][0]["type"]);
//     for(var i=0;i<=data["videos"]["results"].length;i++){
//       if("Trailer"== "${data['videos']['results'][i]['type']}"){
//         print("yessss");
//       }
//     }
//     // _controller = YoutubePlayerController(
//     //     initialVideoId: moviekey,
//     //     flags:const YoutubePlayerFlags(
//     //         autoPlay:false,
//     //         mute: false,
//     //         useHybridComposition: true
//     //     )
//     //
//     // );
//   });
//
// }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final md =MediaQuery.of(context);
//     return LayoutBuilder(
//       builder: (context,constraints){
//         return  Column(
//           children: [
//             Column(
//               children:[
//                 youTubeVideo(id:id),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                         onTap: (){
//                           print("pressed");
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
//                             color: Colors.grey,
//                           ),
//                           height: md.size.height*0.3,
//                           width: constraints.maxWidth*0.49,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(30),
//                                 bottomLeft: Radius.circular(30),
//                               ),
//                               child:Image.network("https://image.tmdb.org/t/p/w200/${imagepath}",fit: BoxFit.cover)
//                           ),
//                         )),
//                     SizedBox(width: constraints.maxWidth*0.01,),
//                     GestureDetector(
//                       onTap: (){
//                         print("pressed");
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(top: 10,bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
//                          // color: Colors.grey,
//                         ),
//                         // child: ClipRRect(
//                         //   borderRadius: BorderRadius.only(
//                         //     topLeft: Radius.circular(30),
//                         //     bottomRight: Radius.circular(30),
//                         //   ),
//                         //   child:Image.network("https://image.tmdb.org/t/p/w400/${widget.overview}",fit: BoxFit.cover) ,
//                         // ),
//                         child: SingleChildScrollView(
//                           child: Column(
//                               children: [
//                                 Text("Title: $title"),
//                             Text("   ${overview}" ,style: TextStyle(fontSize:12),)
//                           ]),
//                         ),
//                         height: md.size.height*0.3,
//                         width: constraints.maxWidth*0.49,
//
//                       ),
//                     ),
//                   ],
//                 ),
//               ]
//           )],
//         );
//       },
//     );
//   }
// }

// for video using id
// https://api.themoviedb.org/3/movie/298618?api_key=1828dc6fe548be842d9bafb3e0db06ea&append_to_response=videos

// for top rated
//https://api.themoviedb.org/3/movie/top_rated?api_key=1828dc6fe548be842d9bafb3e0db06ea

//https://api.themoviedb.org/3/search/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&query=animation&with_genres=16
//https://api.themoviedb.org/3/discover/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&sort_by=vote_average.desc&with_genres=16

// for searching movie by name
//https://api.themoviedb.org/3/search/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&query=Inception

//https://api.themoviedb.org/3/discover/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&sort_by=popularity.desc&with_genres=16;

// for image
// https://image.tmdb.org/t/p/w400/tmU7GeKVybMWFButWEGl2M4GeiP.jpg