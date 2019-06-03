import 'package:flutter/material.dart';
import 'widget/bannerview.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LearnPageState();
  }
}

class _LearnPageState extends State<LearnPage> {
 var urls=["https://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/05/0C/ChMkJ1l_JRCIA-oAAAS5EW43hXUAAfSaAEVxL8ABLkp466.jpg",
  "http://pic1.win4000.com/wallpaper/c/57036e1a7926e.jpg",
  "http://www.meinv.hk/wp-content/themes/Grace/timthumb.php?src=http://www.meinv.hk/wp-content/uploads/2019/04/2019041510355269.jpg&h=300&w=750&zc=1"];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: BannerView(
            (context, index) {
              return Image.network(
                  urls[index],
                  fit: BoxFit.fitWidth);
            },
            (context) {
              return Positioned(
                height: 20,
                width:ScreenUtil.getInstance().setWidth(1080),
                bottom: 10,
                child:Center(child:Text("indicator")),
              );
            },
            itemCount: 3,
            height: 200,
            cycleRolling: true,
                autoRolling: false,
          ))
        ],
      ),
    );
  }
}
