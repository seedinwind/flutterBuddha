import 'package:flutter/material.dart';
import 'widget/bannerview.dart';

class LearnPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LearnPageState();
  }
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: BannerView(
            (context, index) {
              return Image.network(
                  "https://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/05/0C/ChMkJ1l_JRCIA-oAAAS5EW43hXUAAfSaAEVxL8ABLkp466.jpg",
                  fit: BoxFit.fitWidth);
            },
            (context) {
              return Positioned(
                height: 20,
                width: 200,
                bottom: 10,
                child:Center(child:Text("indicator")),
              );
            },
            itemCount: 3,
            height: 200,
            cycleRolling: true,
          ))
        ],
      ),
    );
  }
}
