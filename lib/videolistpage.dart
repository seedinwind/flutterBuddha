import 'package:flutter/material.dart';
import 'playerpage.dart';
import 'bloc/poembloc.dart';
import 'package:dio/dio.dart';
import 'data/Poem.dart';
import 'dart:convert';

class VideoListPage extends StatefulWidget {
  @override
  State<VideoListPage> createState() {
    return _VideoListState();
  }
}

class _VideoListState extends State<VideoListPage> {
  PoemBloc bloc = PoemBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchInitData();
  }

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
        child: StreamBuilder<Response>(
            stream: bloc.dataStream,
            initialData: Response(),
            builder: (context, snapshot) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  if(snapshot.hasData&&null!=snapshot.data.data) {
                    PoemList poems = PoemList.fromJson(snapshot.data.data);
                    return _buildItem(context, index, poems);
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Color.fromARGB(255, 100, 100, 100),
                  );
                },
                itemCount: 20,
              );
            }),
      ),
    );
  }
}

Widget _buildItem(BuildContext context, int index, PoemList poems) {
  return GestureDetector(
    child: Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//      child: Text("十善业道经第" + index.toString() + "讲"),
        child: Text(poems.poems[index].content),
      ),
    ),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PlayerPage(url: "http://47.94.95.216/19-014-0001.mp4");
      }));
    },
  );
}
