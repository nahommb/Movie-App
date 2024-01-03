import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonScreen extends StatelessWidget {
  const SkeletonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery= MediaQuery.of(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.blue.shade100,

      child: LayoutBuilder(
        builder: (context,constraints){
          return Column(
            children:[
              Container(
                width: double.infinity,
                height: mediaQuery.size.height*0.25,
                color: Colors.orange,
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Container(
                    height: mediaQuery.size.height*0.3,
                    width: constraints.maxWidth*0.49,
                    color: Colors.orange,
                  ),
                  SizedBox(width: constraints.maxWidth*0.01,),
                  Container(
                    height: mediaQuery.size.height*0.3,
                    width: constraints.maxWidth*0.49,
                    color: Colors.orange,
                  ),

                ],
              )

            ],
          );
        }
      ),
    );
  }
}
