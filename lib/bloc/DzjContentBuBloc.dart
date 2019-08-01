import 'package:bloc/bloc.dart';
import '../data/datas.dart';
import '../event/events.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../state/states.dart';
import '../net/net.dart';


class DzjContentBuBloc extends Bloc<DzjContentEvent, DzjState> {
  @override
  DzjState get initialState => DzjContentBuLoading();

  @override
  Stream<DzjState> mapEventToState(DzjContentEvent event) async* {
    print("-----------mapEventToState------");

    yield DzjContentBuLoading();
    DzjBuList list = await _getHttp1(event.buming);
    yield DzjContentBuLoaded(content: list);
  }

  Future<DzjBuList> _getHttp1(String buming) async {
    try {
      Response response =
      await DzjService().getBulist(buming);
      print(response.data);
      return DzjBuList.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

}



class TitleBloc extends Bloc<TitleChangeEvent,TitleState>{
  @override
  TitleState get initialState => TitleState("");

  @override
  Stream<TitleState> mapEventToState(TitleChangeEvent event) async* {
    yield TitleState(event.title);
  }

}


class DzjDetailBloc extends Bloc<DzjDetailEvent, DzjState> {
  @override
  DzjState get initialState => DzjContentBuLoading();

  @override
  Stream<DzjState> mapEventToState(DzjDetailEvent event) async* {
    print("-----------mapEventToState------");

    yield DzjDetailLoading();
    DzjDetailList list = await _getHttp1(event.jingti,event.yizhe,event.page);
    yield DzjDetailLoaded(content: list);
  }

  Future<DzjDetailList> _getHttp1(String jingti,String yizhe,int page) async {
    try {
      Response response =
      await DzjService().getJingDetail(jingti,yizhe,page);
      print(response.data);
      return DzjDetailList.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

}
