import 'package:flutter/material.dart';
import 'package:movie/about_screen.dart';


class mainDrawer extends StatelessWidget {
  const mainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 200,
              width: double.infinity,
              //color: Colors.purpleAccent[100],
              child: Image.asset("assets/images/movie5.png",width: double.infinity,height: 100,),
            ),
            Container(
              height: 500,
              padding: EdgeInsets.only(left: 0,top: 30,right: 10),
              child: ListView(
                children: [
                  ListTile(
                    leading:Icon(Icons.star),
                    title: Text("Rate",style: TextStyle(fontSize: 20),),
                    onTap: (){
                    //  Share.share("com.nahom.movie");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading:Icon(Icons.read_more_sharp),
                    title: Text("About",style: TextStyle(fontSize: 20),),
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>aboutScreen()));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
