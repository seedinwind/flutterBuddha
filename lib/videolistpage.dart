import 'package:flutter/material.dart';
import 'playerpage.dart';

class VideoListPage extends StatefulWidget{
  @override
  State<VideoListPage> createState() {
    return _VideoListState();
  }

}

class _VideoListState extends State<VideoListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("VideoList"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.separated(
          itemBuilder:(context, index) {
            return _buildnItem(context, index);
          },
          separatorBuilder: (context,index){
            return Divider(color: Color.fromARGB(255, 100, 100, 100),);
          },
          itemCount: 20,
        ),
      ),
    );
  }

}

Widget _buildnItem(BuildContext context, int index) {
  return GestureDetector(child: Center(
    child: Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Text("十善业道经第"+index.toString()+"讲"),),
  ),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return PlayerPage(url:"http://47.94.95.216/19-014-0001.mp4");
      }));
    },);
}
