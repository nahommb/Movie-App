import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class OnboardingScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          decoration: PageDecoration(

          ),
          title: "Welcome",
          bodyWidget: Container(
            margin: EdgeInsets.only(top: 40),
            width: double.infinity,
            child: Text("You will find here what you want ",style: TextStyle(fontSize: 30,color: Colors.purple,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          image: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200)),
            child: Padding(padding: EdgeInsets.only(top: 20) ,child: Image(image: AssetImage("assets/images/movie1.png"),width: double.infinity,height: 300,)),
          ),
        ),

        PageViewModel(
          decoration: PageDecoration(

          ),
          title: "Adventure",
          bodyWidget: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Text("Every Adventure movies Trailer ",style: TextStyle(fontSize: 30,color: Colors.purple,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          image:  ClipRRect(
            borderRadius: BorderRadius.only(),
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image(image: AssetImage("assets/images/movie2.png"),width: double.infinity,height: 300,),
            ),
          ),
        ),
        PageViewModel(
          title: "Animation",
          bodyWidget: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Text("Best and Top viewed Animation movies ",style: TextStyle(fontSize: 30,color: Colors.purple,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          image: Padding(
    padding:EdgeInsets.only(top: 20),
    child: Image.asset(
              "assets/images/movie3.png",
            ),
          ),
        ),
        PageViewModel(
          title: "All in one",
          bodyWidget: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Text("You will find here what you want ",style: TextStyle(fontSize: 30,color: Colors.purple,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
          image: Padding(padding:EdgeInsets.only(top: 20) ,child: Image(image: AssetImage("assets/images/movie4.png",),width: double.infinity,height: 300,))
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip',style: TextStyle(color: Colors.purple),),
      next: const Icon(Icons.arrow_forward,color: Colors.purple,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.purple)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.purple,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.purple,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}