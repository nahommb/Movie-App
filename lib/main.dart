
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // or any loading indicator
          } else if (snapshot.hasError) {
            return Container(); // or error indicator
          } else {
            bool firstTimeUser = snapshot?.data?.getBool('onboardingCompleted') != true ?? true;
          //  bool firstTimeUser = !snapshot.data!.getBool('onboardingCompleted') ?? true;
            return (firstTimeUser) ? OnboardingScreen() : HomeScreen();
          }
        },
      ),
    );
  }
}





class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

   IconData icn=Icons.nightlight_sharp;
   ThemeData thmData =ThemeData(colorScheme: ColorScheme.light());
   bool daylight = true;

  Widget nightmood(){
    return IconButton(

        onPressed: (){
          if(!daylight){
            setState(() {
              thmData =ThemeData(colorScheme: ColorScheme.light());
              icn=Icons.nightlight_sharp;
              daylight =true;
            });
          }
          else{
            setState(() {
              thmData =ThemeData(colorScheme: ColorScheme.dark());
              icn=Icons.light_mode;
              daylight =false;
            });
          }
        },
        icon:Icon(icn,color: Colors.purple)
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: thmData,
      home: homePage(nightmood()),
    );
  }
}
