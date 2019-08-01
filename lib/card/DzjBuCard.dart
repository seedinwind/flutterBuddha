import 'package:flutter/material.dart';
 class DzjBuCard extends StatelessWidget{
   String content;
   GestureTapCallback onTap;
   DzjBuCard(String content,GestureTapCallback onTap){
     this.content=content;
     this.onTap=onTap;
   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Center(
            child:  Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child:  SizedBox.fromSize(
                  child:Text(content),
                  size: Size.fromWidth(20)
              ),

            )
        ),
        onTap: onTap
    );
  }
 }