import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'moviedata.dart';

class popmenu extends StatefulWidget {


  @override
  State<popmenu> createState() => _popmenuState();
}

class _popmenuState extends State<popmenu> {
  List<Widget> movcont=[
    // Container(
    //   child: Text("King Kong"),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'top_rated',
          child: Text('Top rated'),
        ),
        const PopupMenuItem<String>(
          value: 'option2',
          child: Text('New'),
        ),
        const PopupMenuItem<String>(
          value: 'option3',
          child: Text("Animation"),
        ),
      ],
      onSelected: (String value) {
        void getdat() async{
            var url = Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=1828dc6fe548be842d9bafb3e0db06ea");

            https.Response rs = await https.get(url);
            final apibody = rs.body;
            //print(apibody);
            final data = jsonDecode(apibody);
            print("total api movie ${data.length}");

            for (int i=0;i<=data["results"].length;i++){

              int movieId =data["results"][i]["id"];
              print(movieId.toString());
              var video_url = Uri.parse("https://api.themoviedb.org/3/movie/${movieId.toString()}?api_key=1828dc6fe548be842d9bafb3e0db06ea&append_to_response=videos");
              https.Response video_rs = await https.get(video_url);

              // print(rss.body);
              final video_apibody = video_rs.body;
              final video_data = jsonDecode(video_apibody);

              setState(() {
                // movname.add(data["results"][i]["title"]);
                String imgpath = data["results"][i]["poster_path"];
                String overview = data["results"][i]["overview"];
                String title = data["results"][i]["title"];
                String moviekey;
                try{
                  for(var j=0;j<=video_data["videos"]["results"].length;j++){
                    if("Trailer"== "${video_data['videos']['results'][j]['type']}"){
                      print("yessss");
                      moviekey = video_data["videos"]["results"][j]["key"];
                      movcont.add(movieData(imagepath: imgpath,overview: overview,title: title,id:moviekey));
                      break;
                    }}

                }
                catch (e){
                  moviekey="";
                  movcont.add(movieData(imagepath: imgpath,overview: overview,title: title,id:moviekey));
                }
                //print(moviekey);

              });

            }
          }
          print('Selected option: $value');
        }
    );
  }
}
