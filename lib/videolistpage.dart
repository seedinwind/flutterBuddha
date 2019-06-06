import 'package:flutter/material.dart';
import 'playerpage.dart';
import 'bloc/poembloc.dart';
import 'data/poem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event/poemEvent.dart';
import 'state/states.dart';

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
    super.initState();
    bloc.dispatch(PoemEvent());
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
        child: BlocProvider(
            bloc: bloc,
            child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is PoemListLoaded) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return _buildItem(context, index, state.poems);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Color.fromARGB(255, 100, 100, 100),
                        );
                      },
                      itemCount: state.poems.poems == null
                          ? 0
                          : state.poems.poems.length,
                    );
                  } else {
//              return  showEmpty();
                  }
                })),
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
