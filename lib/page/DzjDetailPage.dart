import 'package:flutter/material.dart';
import '../bloc/blocs.dart';
import '../event/events.dart';
import '../state/states.dart';
import '../widget/BlocWrapper.dart';
import '../card/cards.dart';

class DzjDetailPage extends StatefulWidget {
  String jingti;

  String yizhe;
  DzjDetailPage(this.jingti,this.yizhe);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DzjDetailPageState();
  }

}

class _DzjDetailPageState extends State<DzjDetailPage> {

  DzjDetailBloc bloc = DzjDetailBloc();

  @override
  void initState() {
    super.initState();
    bloc.dispatch(DzjDetailEvent(widget.jingti,widget.yizhe,0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.jingti),),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: BlocWrapper(bloc, (context,state){
          if(state is DzjDetailLoaded) {
            return Column(
              children: <Widget>[
                SizedBox.fromSize(
                  child: Padding(padding: EdgeInsets.fromLTRB(20, 15, 0, 15),child:Text(state.content.contents[0].yizhe), ),
                  size: Size.fromHeight(50),
                ),

                Expanded(
                child:ListView.builder(itemBuilder: (context,index){
                  return DzjContentCard(state.content.contents[index]);
                },itemCount: state.content.contents.length,
                ))],
            );
          }else{
            return Container();
          }
        }),
      ),
    );
  }
}
