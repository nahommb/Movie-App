import 'package:flutter/material.dart';

class aboutScreen extends StatelessWidget {
  const aboutScreen({Key? key}) : super(key: key);

  Card cardProfile(String title,String subtitle,IconData icon){
    return Card(
      child: ListTile(
        leading: Icon(icon,color:Colors.purple,size: 25,),
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),),
        subtitle: SelectableText(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About"),centerTitle: true,backgroundColor: Colors.black,),
      body: Container(
        child: Column(
          children: [
            cardProfile("Version", "1.0", Icons.android),
            cardProfile("Developer", "Nahom Melese", Icons.computer),
            cardProfile("Tele", "+251946596354", Icons.phone),
            //cardProfile("Instagram", "nahom_mb", Icons.m)

          ],
        ),
      ),
    );
  }
}
