import 'package:flutter/material.dart';
import '../bloc/blocs.dart';

import '../data/Dzj.dart';
import '../state/states.dart';
import '../card/cards.dart';
import '../event/events.dart';
import '../widget/BlocWrapper.dart';

import 'DzjDetailPage.dart';

class DzjContentPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DzjContentState();
  }

}

class _DzjContentState extends State<DzjContentPage> {

  DzjContentBloc bloc = DzjContentBloc();
  DzjContentBuBloc bloc1 = DzjContentBuBloc();
  TitleBloc titleBloc= TitleBloc();

  String buming="";
  DzjBuList list = DzjBuList();

  @override
  void initState() {
    super.initState();
    bloc.dispatch(DzjContentEvent(DzjContentEventType.Bu));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
           _buildHeader(),
           _buildBodyContent(),
          ],
        )
    );
  }



  _buildHeader() {
    return SliverAppBar(
      //标题居中
      centerTitle: true,
      //展开高度
      expandedHeight: 200.0,
      //固定在顶部
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title:BlocWrapper(titleBloc, (context,state){
          if(state is TitleState) {
            return Text(state.title);
          }
        }) ,
        background: BlocWrapper(bloc,
                (context, state) {
              if (state is DzjContentLoaded) {
                list = state.content;
                buming = state.content.contents[0].buming;
                if(state.init) {
                  titleBloc.dispatch(TitleChangeEvent(buming));
                  bloc1.dispatch(DzjContentEvent(
                      DzjContentEventType.Jing, buming: buming));
                }
                state.init=false;
                return _buildHeaderListView(state.content);
              } else if(state is DzjContentLoading){
                return  Container();
              }
            }),
      ),
    );
  }

  Widget _buildHeaderListView(DzjBuList list) {
    return SizedBox.fromSize(
        child: Padding(
          child: ListView.separated(
            scrollDirection:Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildDzjBuCard(context, index, list);
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Color.fromARGB(50, 50, 50, 50),
              );
            },
            itemCount: list.contents == null
                ? 0
                : list.contents.length,
          ),
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),)
        ,size: Size.fromHeight(200));
  }

  _buildBodyContent() {
    return BlocWrapper(bloc1,(context, state) {
      if (state is DzjContentBuLoaded) {
        return  _buildBodyList(state);
      } else {
        return SliverToBoxAdapter(child:Container()) ;
      }
    });

  }

  Widget _buildBodyList(DzjContentBuLoaded state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context,index){
        return _buildDzjJingCard(context, index, state.content);
      },
          childCount:state.content.contents.length
      ),
    );
  }


  Widget _buildDzjBuCard(BuildContext context, int index, DzjBuList content) {
    return DzjBuCard(content.contents[index].buming, (){clickBu(content, index);});
  }


  Widget _buildDzjJingCard(BuildContext context, int index, DzjBuList content) {
    return DzjJingCard(content.contents[index],
            (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DzjDetailPage(content.contents[index].buming,content.contents[index].yizhe);
          }));
        }
    );
  }

  clickBu(DzjBuList content,int index){
    buming = content.contents[index].buming;
    titleBloc.dispatch(TitleChangeEvent(buming));
    bloc1.dispatch(DzjContentEvent(DzjContentEventType.Jing,buming:buming));
  }

}












