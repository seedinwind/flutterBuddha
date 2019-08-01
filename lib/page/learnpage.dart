import 'package:flutter/material.dart';
import '../widget/bannerview.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../page/DzjContentPage.dart';
import 'package:buddhawise/page/playerpage.dart';


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
              child: buildBannerView()),
          SliverPadding(
            sliver:SliverToBoxAdapter(
              child: buildCommonSection(),
            ),
            padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
          )

        ],
      ),
    );
  }

  BannerView buildBannerView() {
    return BannerView(
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
    );
  }

  buildCommonSection() {
    return  SizedBox.fromSize(
        child: Row(children:[

        Expanded(
              child:
              GestureDetector(
                  child: Column(children:[
                Icon(Icons.book),
                Text("佛经")
              ]),onTap:clickBook),
              flex:1),

          Expanded(
            child:GestureDetector(
              child: Column(children:[
                Icon(Icons.video_label),
                Text("讲经")
              ]),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PlayerPage(url: "http://47.94.95.216/19-014-0001.mp4");
                }));
              },
            ),
              flex:1),
          Expanded(
              child:
              Column(children:[
                Icon(Icons.home),
                Text("寺院")
              ]),
              flex:1),
        ]),
        size:Size(ScreenUtil.getInstance().setWidth(1080), 50)
    );
  }

  void clickBook() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DzjContentPage();
    }));
  }
}
