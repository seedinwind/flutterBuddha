import 'package:flutter/material.dart';
import '../data/datas.dart';

class DzjContentCard extends StatelessWidget{
  DzjDetail detail;
  DzjContentCard(DzjDetail detail){
    this.detail=detail;
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(detail.pinming+"\r\n",textAlign: TextAlign.center,),
      Text("   "+detail.content+"\r\n")
    ],);
  }

}