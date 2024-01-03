import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/main_drawer.dart';
import 'package:movie/pop_menu.dart';
import 'package:movie/skeleton_screen.dart';
import 'moviedata.dart';
import 'package:http/http.dart' as https;
import 'package:shimmer/shimmer.dart';

class homePage extends StatefulWidget {

 final Widget icn;
  homePage(this.icn);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {



  final textcontroller = TextEditingController();
  String trending = "https://api.themoviedb.org/3/trending/all/week?api_key=1828dc6fe548be842d9bafb3e0db06ea";
  final appBar = AppBar(
    backgroundColor: Colors.black,
    title: Text("NiMovie"),
    centerTitle: true,

  );
  late String moviename;

 FocusNode _focusNode = FocusNode();


  List<Widget> movcont=[];

  Future getdata(String Type) async{
    var url = Uri.parse(Type);

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
   // print("total ${movname.length}");
  }

  Future searchdata(String moviename) async{
    var url = Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&query=$moviename");

    https.Response rs = await https.get(url);
    final apibody = rs.body;
    //print(apibody);
    final data = jsonDecode(apibody);
    print("total api movie ${data.length}");

    for (int i=0;i<=data["results"].length;i++){
      int movieId =data["results"][i]["id"];

      var video_url = Uri.parse("https://api.themoviedb.org/3/movie/${movieId}?api_key=1828dc6fe548be842d9bafb3e0db06ea&append_to_response=videos");
      https.Response video_rs = await https.get(video_url);
      final video_apibody = video_rs.body;
      final video_data = jsonDecode(video_apibody);


      setState(() {
        String imgpath = data["results"][i]["poster_path"];
        String overview = data["results"][i]["overview"];
        String title = data["results"][i]["title"];
        String moviekey;
        try{
          for(var j=0;j<=video_data["videos"]["results"].length;j++){
            if("Trailer"== "${video_data['videos']['results'][j]['type']}"){
              moviekey = video_data["videos"]["results"][j]["key"];
              movcont.add(movieData(imagepath: imgpath,overview: overview,title: title,id:moviekey));
              break;
            }}
        }
        catch (e){
          try{
           moviekey = video_data["videos"]["results"][0]["key"];
           movcont.add(movieData(imagepath: imgpath,overview: overview,title: title,id: moviekey,));
         }
          catch(e){
            moviekey="";
            movcont.add(movieData(imagepath: imgpath,overview: overview,title: title,id: moviekey,));
          }
        }

      });

    }
    //print("total ${movname.length}");
  }

@override
  void initState(){
    // TODO: implement initState
    super.initState();

    setState(() {
     getdata(trending);
    });
  }
  
  @override
  Widget build(BuildContext context) {

    final mediaQuery=MediaQuery.of(context);
    final body = SingleChildScrollView(
      child: GestureDetector(
        onTap: (){
          setState(() {
            _focusNode.unfocus();
            print('yyyyy');
          });
        },
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10,top: 20 ,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                        movcont.clear();
                        getdata("trending");

                    }, icon: Icon(Icons.home,color: Colors.purple,)),
                    Row(
                      children: [
                        widget.icn,
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert_outlined,color: Colors.purple),
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'top_rated',
                              child: Text('Top rated'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'animation',
                              child: Text('Animation'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'romantic',
                              child: Text("Romantic"),
                            ),
                            const PopupMenuItem<String>(
                              value: 'horror',
                              child: Text("Horror"),
                            )
                          ],
                          onSelected: (value){
                            setState(() {
                              movcont.clear();
                              if(value=="top_rated"){
                                getdata("https://api.themoviedb.org/3/movie/top_rated?api_key=1828dc6fe548be842d9bafb3e0db06ea");
                              }
                              else if(value=="animation"){
                                getdata("https://api.themoviedb.org/3/discover/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&sort_by=popularity.desc&with_genres=16");
                              }
                              else if(value=="romantic"){
                                getdata("https://api.themoviedb.org/3/discover/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&sort_by=popularity.desc&with_genres=10749");
                              }

                              else if(value=="horror"){
                                getdata("https://api.themoviedb.org/3/discover/movie?api_key=1828dc6fe548be842d9bafb3e0db06ea&sort_by=popularity.desc&with_genres=27");
                              }
                            });

                          }),
                      ],
                    )
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                        children:[
                          Text("Find your Dream Movies",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                          SizedBox(height: 15,),
                          Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: TextField(
                                   focusNode: _focusNode,
                                   controller: textcontroller,
                                   onChanged: (value){
                                     setState(() {
                                       moviename=value;
                                     });
                                   },
                                   onSubmitted: (value) {
                                     setState(() {
                                       movcont.clear();
                                       searchdata(value);
                                     });
                                   },
                                  //controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    suffixIcon: TextButton.icon(
                                      onPressed: () {
                                     setState(() {
                                       movcont.clear();
                                        searchdata(moviename);
                                       _focusNode.unfocus();
                                     });

                                    },
                                      icon: Icon(Icons.search),label: Text("search"),),
                                    border: OutlineInputBorder(),
                                  )
                              ))]
                    )),
               // SizedBox(height: mediaQuery.size.height*0.01,),
                (movcont.isEmpty)? Container(
                  height: mediaQuery.size.height*0.65,
                    child:  ListView.builder(
                      itemBuilder:  (context,index){
                        return  Column(
                            children:[
                              SkeletonScreen(),
                              SizedBox(height: 15,)
                            ]
                        );
                      },
                      itemCount:2,
                    ),
                ):
                Container(
                  height: mediaQuery.size.height*0.65,
                  child: ListView.builder(
                    itemBuilder:  (context,index){
                      return  Column(
                        children: [
                          movcont[index],
                          SizedBox(height: 30,)
                        ],
                      );
                    },
                    itemCount:movcont.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:mediaQuery.orientation==Orientation.portrait?appBar:null,
      drawer: mainDrawer(),
      body: mediaQuery.orientation==Orientation.portrait? body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10,top: 5 ,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: mediaQuery.size.height*0.9,
                  child: ListView.builder(
                    itemBuilder: (context,index){
                      return movcont[index];
                    },
                    itemCount: movcont.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}