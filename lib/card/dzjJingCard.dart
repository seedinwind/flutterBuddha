import 'package:flutter/material.dart';
import '../data/datas.dart';

class DzjJingCard extends StatelessWidget {
  DzjContent content;
  GestureTapCallback onTap;

  DzjJingCard(DzjContent content,GestureTapCallback onTap){
    this.content=content;
    this.onTap=onTap;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//      child: Text("十善业道经第" + index.toString() + "讲"),
            child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(content.buming,textAlign: TextAlign.left,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text(content.yizhe,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.normal)),
                  ],
                ),

      ),
      onTap:onTap,
    );
  }
}

